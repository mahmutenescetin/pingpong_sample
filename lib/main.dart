import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingpong_sample/firebase_options.dart';
import 'package:pingpong_sample/services/remote/auth_service.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/views/login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/utils/extensions/object_extensions.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isOnline = false;

  ConnectivityProvider() {
    _init();
  }

  void _init() {
    Connectivity().checkConnectivity().then((result) {
      isOnline = result != ConnectivityResult.none;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((result) {
      isOnline = result != ConnectivityResult.none;
      notifyListeners();
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(' Arka planda mesaj alındı:  [38;5;2m${message.messageId} [0m');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  await locator<SharedPreferenceService>().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ConnectivityProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const AuthGate(),
        );
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  static bool _fcmInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    if (_fcmInitialized) return;
    _fcmInitialized = true;

    final token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(notification.title ?? 'Yeni Bildirim')),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Bildirime tıklandı: ${notification.title}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(locator<SharedPreferenceService>());

    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginView();
          } else {
            return const HomeView();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _viewModel;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final isOnline = context.read<ConnectivityProvider>().isOnline;
      _viewModel = HomeViewModel(locator<SharedPreferenceService>());
      _viewModel.fetchActivity(isOnline: isOnline);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = context.watch<ConnectivityProvider>().isOnline;
    return ViewModelBuilder<HomeViewModel>(
      initViewModel: () => _viewModel,
      builder: (context, viewModel) {
        if (!viewModel.isLoaded || viewModel.isBusy) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (viewModel.activity.isNull || viewModel.activity.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Hiç etkinlik yok veya çevrimdışısınız. Son veri bulunamadı.',
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Etkinlikler'),
            actions: [
              Row(
                children: [
                  Icon(
                    isOnline ? Icons.wifi : Icons.wifi_off,
                    color: isOnline ? Colors.green : Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () =>
                        viewModel.fetchActivity(isOnline: isOnline),
                    tooltip: 'Yenile',
                  ),
                ],
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: viewModel.activity.length,
            itemBuilder: (context, index) {
              final activity = viewModel.activity[index];
              return ListTile(
                title: Text(activity['title'] ?? ''),
                subtitle: Text(activity['description'] ?? ''),
                trailing: Text(
                  activity['date'] != null
                      ? (() {
                          final date = activity['date'];
                          if (date is String) {
                            return DateTime.tryParse(date)?.toString() ?? date;
                          } else if (date is Timestamp) {
                            return date.toDate().toString();
                          } else {
                            return date.toString();
                          }
                        })()
                      : '',
                ),
              );
            },
          ),
        );
      },
    );
  }
}

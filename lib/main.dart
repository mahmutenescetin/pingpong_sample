import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingpong_sample/firebase_options.dart';
import 'package:pingpong_sample/routes/create_view.dart';
import 'package:pingpong_sample/routes/generate_routes.dart';
import 'package:pingpong_sample/routes/routes.g.dart';
import 'package:pingpong_sample/services/remote/auth_service.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/utils/navigator_util.dart';
import 'package:pingpong_sample/views/home/home_view.dart';
import 'package:pingpong_sample/views/login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:pingpong_sample/providers/connectivity_provider.dart';
import 'package:pingpong_sample/themes/themes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(' Arka planda mesaj alındı: ${message.messageId}');
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
          navigatorKey: rootNavigator,
          onGenerateRoute: onGenerateRoute,
          home: AuthGate(),
          theme: Themes.lightTheme,
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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingpong_sample/firebase_options.dart';
import 'package:pingpong_sample/services/remote/auth_service.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/views/home/home_view.dart';
import 'package:pingpong_sample/views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  await locator<SharedPreferenceService>().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: AuthGate(),
        );
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(locator<SharedPreferenceService>());
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginView();
          } else {
            return HomeView(); 
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
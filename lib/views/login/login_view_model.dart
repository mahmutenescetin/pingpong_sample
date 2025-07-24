import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/routes/routes.g.dart';
import 'package:pingpong_sample/services/remote/auth_service.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/utils/locator.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AuthService _authService;

  LoginViewModel() {
    _authService = AuthService(locator<SharedPreferenceService>());
  }

  Future<void> register() async {
    try {
      await _authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (!mounted) return;
      showFlushBar("Kayıt başarılı");
    } catch (e) {
      if (!mounted) return;
      showFlushBar("Kayıt başarısız: $e'");
    }
    
  }

  Future<void> login() async {
    try {
      await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (!mounted) return;
      showFlushBar('Giriş başarılı');
      navigate(Routes.home, clearStack: true);
    } catch (e) {
      if (!mounted) return;
      showFlushBar('Giriş başarısız: $e');
    }
  }

  String? getToken() {
    return _authService.getToken();
  }

  bool get isLoggedIn => _authService.currentUser != null;

  Stream<bool> get authStateChanges =>
      _authService.authStateChanges.map((user) => user != null);

  Future<void> logout() async {
    await _authService.signOut();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

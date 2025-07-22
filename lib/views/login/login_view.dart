import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/views/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>(
      initViewModel: () => LoginViewModel(),
      builder: (context, viewModel) => StreamBuilder<bool>(
        stream: viewModel.authStateChanges,
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data ?? viewModel.isLoggedIn;
          if (!isLoggedIn) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gap(context.vGap),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: viewModel.passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.login,
                      child: const Text("Giriş Yap"),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.register,
                      child: const Text("Kayıt Ol"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Ana Sayfa'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => viewModel.logout(),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Eklendi
                  children: [
                    const Text('Giriş başarılı!'),
                    const SizedBox(height: 16),
                    Text('Token: \n${viewModel.getToken() ?? "Yok"}'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

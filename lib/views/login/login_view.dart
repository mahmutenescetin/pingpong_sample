import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/views/login/login_view_model.dart';
import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/common/widgets/reusable_elevated_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>(
      initViewModel: () => LoginViewModel(),
      builder: (context, viewModel) => StreamBuilder<bool>(
        stream: viewModel.authStateChanges,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                width: 380,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ReusableText(
                      'Hoş geldin!',
                      style: context.textStyles.title.t18Semibold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ReusableText(
                      'Lütfen giriş yap veya kayıt ol',
                      style: context.textStyles.body.b16Regular.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: InputDecoration(
                        labelText: 'E-posta',
                        labelStyle: context.textStyles.body.b16Regular,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: viewModel.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        labelStyle: context.textStyles.body.b16Regular,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    ReusableElevatedButton(
                      text: 'Giriş Yap',
                      onPressed: viewModel.login,
                      expanded: true,
                      enableButtonColor: Colors.purple,
                    ),
                    const SizedBox(height: 12),
                    ReusableElevatedButton.secondaryButton(
                      text: 'Kayıt Ol',
                      onPressed: viewModel.register,
                      expanded: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

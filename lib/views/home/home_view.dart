import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      initViewModel: () => HomeViewModel(),
      builder: (context, viewModel) => Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.hGap),
          child: Column(
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
                onPressed: () {
                  viewModel.login(context);
                },
                child: const Text("Giriş Yap"),
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.register(context);
                },
                child: const Text("Kayıt Ol"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      initViewModel: () => HomeViewModel(),
      builder: (context, viewModel) => Container(color: Colors.red,));
  }
}


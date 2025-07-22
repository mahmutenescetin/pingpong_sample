import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      initViewModel: () => HomeViewModel(),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(title: const Text('Etkinlikler')),
          body: ListView.builder(
            itemCount: viewModel.activity.length,
            itemBuilder: (context, index) {
              final activity = viewModel.activity[index];
              return ListTile(
                title: Text(activity['title'] ?? ''),
                subtitle: Text(activity['description'] ?? ''),
                trailing: Text(
                  activity['date'] != null
                      ? (activity['date'] as Timestamp).toDate().toString()
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

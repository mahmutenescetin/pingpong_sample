import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/providers/connectivity_provider.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/utils/extensions/object_extensions.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print('HomeView build tetiklendi');
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, _) {
        final isOnline = connectivityProvider.isOnline;
        return ViewModelBuilder<HomeViewModel>(
          initViewModel: () => HomeViewModel(locator<SharedPreferenceService>()),
          builder: (context, viewModel) {
            if (viewModel.lastIsOnline != isOnline) {
              viewModel.lastIsOnline = isOnline;
              viewModel.fetchActivity(isOnline: isOnline);
            }
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
                        onPressed: () => viewModel.fetchActivity(isOnline: isOnline),
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
      },
    );
  }
}

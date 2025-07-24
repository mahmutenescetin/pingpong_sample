import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/routes/routes.g.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import '../../services/local/activity_local_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  List<Map<String, dynamic>> activity = [];
  bool isLoaded = false;
  bool? lastIsOnline;

  String _selectedCategoryName = 'Hepsi';
  int _bottomNavIndex = 0;
  final Map<int, bool> _localFavorites = {};

  String get selectedCategoryName => _selectedCategoryName;

  int get bottomNavIndex => _bottomNavIndex;

  Map<int, bool> get localFavorites => _localFavorites;

  final SharedPreferenceService _prefsService;
  late final ActivityLocalService _localService;

  HomeViewModel(this._prefsService) {
    _localService = ActivityLocalService(_prefsService);
  }

  void setCategory(String category) {
    _selectedCategoryName = category;
    notify();
  }

  void setBottomNavIndex(int index) {
    _bottomNavIndex = index;
    notify();
  }

  void toggleFavorite(int index) {
    _localFavorites[index] = !(_localFavorites[index] ?? false);
    notify();
  }

  Future<void> fetchActivity({
    bool forceOnline = false,
    bool isOnline = false,
  }) async {
    isLoaded = false;
    notify();
    if (isOnline || forceOnline) {
      await flowWithFirestore<List<Map<String, dynamic>>>(
        callback: () async {
          final snapshot = await FirebaseFirestore.instance
              .collection('activity')
              .get();
          final data = snapshot.docs.map((doc) {
            final map = doc.data();
            if (map['date'] != null && map['date'] is Timestamp) {
              map['date'] = (map['date'] as Timestamp)
                  .toDate()
                  .toIso8601String();
            }
            return map;
          }).toList();
          await _localService.saveActivityList(data);
          return data;
        },
        onSuccess: (data) {
          activity = data;
          isLoaded = true;
          notify();
        },
        onError: (e) async {
          activity = await _localService.getActivityList();
          isLoaded = true;
          notify();
        },
        onFinally: () {},
      );
    } else {
      activity = await _localService.getActivityList();
      isLoaded = true;
      notify();
    }
  }

  void logOut()  async {
    await FirebaseAuth.instance.signOut();
    navigate(Routes.login, clearStack: true);
  }
}

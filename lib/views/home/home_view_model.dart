import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import '../../services/local/activity_local_service.dart';

class HomeViewModel extends BaseViewModel {
  List<Map<String, dynamic>> activity = [];
  bool isLoaded = false;
  bool? lastIsOnline;

  final SharedPreferenceService _prefsService;
  late final ActivityLocalService _localService;

  HomeViewModel(this._prefsService) {
    _localService = ActivityLocalService(_prefsService);
  }

  @override
  void onBindingCreated() {
    super.onBindingCreated();
  }

  Future<void> fetchActivity({bool forceOnline = false, bool isOnline = false}) async {
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
}

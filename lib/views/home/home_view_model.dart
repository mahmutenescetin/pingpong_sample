import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import '../../services/local/activity_local_service.dart';

class HomeViewModel extends BaseViewModel {
  List<Map<String, dynamic>> activity = [];
  bool isLoaded = false;

  final SharedPreferenceService _prefsService;
  late final ActivityLocalService _localService;

  HomeViewModel(this._prefsService) {
    _localService = ActivityLocalService(_prefsService);
  }

  @override
  void onBindingCreated() {
    super.onBindingCreated();
    fetchActivity();
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
          print('Firestore snapshot docs: ${snapshot.docs.length}');
          final data = snapshot.docs.map((doc) {
            final map = doc.data();
            if (map['date'] != null && map['date'] is Timestamp) {
              map['date'] = (map['date'] as Timestamp)
                  .toDate()
                  .toIso8601String();
            }
            return map;
          }).toList();
          print('Firestore data: $data');
          await _localService.saveActivityList(data);
          return data;
        },
        onSuccess: (data) {
          print('onSuccess, data: $data');
          activity = data;
          isLoaded = true;
          notify();
        },
        onError: (e) async {
          print('onError: $e');
          activity = await _localService.getActivityList();
          isLoaded = true;
          notify();
        },
        onFinally: () {
          print('onFinally');
        },
      );
    } else {
      print('Offline, local cache denenecek');
      activity = await _localService.getActivityList();
      isLoaded = true;
      notify();
    }
  }
}

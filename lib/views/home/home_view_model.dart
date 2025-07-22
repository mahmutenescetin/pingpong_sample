import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingpong_sample/common/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  List<Map<String, dynamic>> activity = [];
  bool isLoaded = false;

  @override
  void onBindingCreated() {
    super.onBindingCreated();
    fetchActivity();
  }

  Future<void> fetchActivity() async {
    await flowWithFirestore<List<Map<String, dynamic>>>(
      callback: () async {
        final snapshot = await FirebaseFirestore.instance
            .collection('activity')
            .get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      onSuccess: (data) {
        activity = data;
        isLoaded = true;
        notify();
      },
      onError: (e) {
        isLoaded = true;
        notify();
      },
      onFinally: () {
        isLoaded = true;
        notify();
      },
    );
  }
}

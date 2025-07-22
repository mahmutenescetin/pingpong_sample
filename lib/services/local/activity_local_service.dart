import 'dart:convert';
import 'package:pingpong_sample/constants/shared_key_constants.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';

class ActivityLocalService {
    ActivityLocalService(this._prefsService);
  final SharedPreferenceService _prefsService;


  Future<void> saveActivityList(List<Map<String, dynamic>> activityList) async {
    
    final jsonString = jsonEncode(activityList);
    await _prefsService.set(SharedKeyConstants.activityList, jsonString);
  }

  Future<List<Map<String, dynamic>>> getActivityList() async {
    
    final String? jsonString = _prefsService.get<String>(SharedKeyConstants.activityList);
    if (jsonString == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.cast<Map<String, dynamic>>();
  }
} 
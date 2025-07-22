import 'dart:convert';

import 'package:pingpong_sample/constants/shared_key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const _prefix = 'pingpongSample_';
  final Map<SharedKeyConstants, Object?> _cache = {};

  String _getRawKey(SharedKeyConstants key) => '$_prefix${key.value}';

  Future<bool> set(SharedKeyConstants key, Object? value) {
    _cache[key] = value;
    final rawKey = _getRawKey(key);

    if (value == null) {
      _cache.remove(key);
      return _prefs.remove(rawKey);
    } else if (value is int) {
      return _prefs.setInt(rawKey, value);
    } else if (value is double) {
      return _prefs.setDouble(rawKey, value);
    } else if (value is bool) {
      return _prefs.setBool(rawKey, value);
    } else if (value is String) {
      return _prefs.setString(rawKey, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(rawKey, value);
    } else if (value is Map<String, dynamic>) {
      return _prefs.setString(rawKey, json.encode(value));
    } else {
      _cache.remove(key);
      throw Exception('Invalid Type');
    }
  }

  T? get<T>(SharedKeyConstants key) {
    if (_cache.containsKey(key)) {
      return _cache[key] as T?;
    }

    T? value;
    final rawKey = _getRawKey(key);

    if (T == int) {
      value = _prefs.getInt(rawKey) as T?;
    } else if (T == double) {
      value = _prefs.getDouble(rawKey) as T?;
    } else if (T == bool) {
      value = _prefs.getBool(rawKey) as T?;
    } else if (T == String) {
      value = _prefs.getString(rawKey) as T?;
    } else if (T == List<String>) {
      value = _prefs.getStringList(rawKey) as T?;
    } else if (T == Map<String, dynamic>) {
      value = _prefs.getString(rawKey) != null
          ? jsonDecode(_prefs.getString(rawKey)!) as T?
          : null;
    } else {
      throw Exception('Invalid value type!');
    }

    _cache[key] = value;
    return value;
  }

  Future<void> clear() async {
    _cache.clear();

    final keys = SharedKeyConstants.values.map((e) => _getRawKey(e)).toList();

    for (final key in keys) {
      await _prefs.remove(key);
    }
  }


}

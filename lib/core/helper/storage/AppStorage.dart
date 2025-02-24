import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../commons/constants/string.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._internal();
  late final Box _box;

  AppStorage._internal();

  static AppStorage get instance => _instance;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _instance._box = await Hive.openBox(AppString.SECURE_STORAGE_NAME);
  }

  Future<void> put<T>(String key, T value) async {
    try {
      await _box.put(key, value);
    } catch (e) {
      debugPrint('Failed to save data: $e');
    }
  }

  T? get<T>(String key) {
    try {
      return _box.get(key) as T?;
    } catch (e) {
      debugPrint('Failed to retrieve data: $e');
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _box.delete(key);
    } catch (e) {
      debugPrint('Failed to delete data: $e');
    }
  }

  bool containsKey(String key) {
    return _box.containsKey(key);
  }
}

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class Store {
  Future<bool> clear();
  Future<bool> commit();
  bool containsKey(String key);
  Object? get(String key);
  bool? getBool(String key);
  double? getDouble(String key);
  int? getInt(String key);
  Set<String> getKeys();
  String? getString(String key);
  List<String>? getStringList(String key);
  Future<void> reload();
  Future<bool> remove(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setInt(String key, int value);
  Future<bool> setString(String key, String value);
}

class AppStore {
  static late final SharedPreferences instance;

  static Future init() async {
      instance = await SharedPreferences.getInstance();
  }

  
}

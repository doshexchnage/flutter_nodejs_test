import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker/api/user_api.dart';

import '../models/user_model.dart';
import '../transforms/store_utils.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences? storage;
  final AuthApi? api;

  User? user;
  bool isAuthenticated = false;
  User? get getUser => user;
  bool get getIsAuthenticated => isAuthenticated;

  AuthProvider({this.api, this.storage}) {
     loadFromStore();
  }

  void loadFromStore() async {
    try {
      isAuthenticated = await storage?.getBool('isAuthenticated')! ?? false;
      user = User.fromJson(await getClassFromStore(storage, 'user'));
      notifyListeners();
    } catch (e) {
      print('store is empty');
    }
  }

  void userSignIn(payload) async {
    try {
      final response = await api?.login(payload);
      user = response;
      isAuthenticated = true;
      storage?.setBool('isAuthenticated', isAuthenticated);
      saveStringToStore(storage, 'user', response);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  void userSignup(payload) async {
    try {
      user = await api?.signup(payload);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }
}

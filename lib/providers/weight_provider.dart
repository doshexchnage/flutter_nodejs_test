import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/weight_api.dart';
import '../models/weight_model.dart';

class WeightProvider extends ChangeNotifier {
  final SharedPreferences? storage;
  final WeightApi? api;

  List<Weight>? weightHistory = [];
  List<Weight>? get getWeightHistory => weightHistory;

  WeightProvider({this.storage, this.api});

  void setWeightHistory(List<Weight> weight) {
    weightHistory = weight;
    notifyListeners();
  }

  void addToWeightHistory(Weight weight) {
    weightHistory?.add(weight);
    notifyListeners();
  }

  void fetchWeightHistory() async {
    try {
      final response = await api?.getWeightHistory();
      setWeightHistory(response!);
    } catch (e) {
      throw e.toString();
    }
  }

  void updateWeightHistory(payload) async {
    try {
      final weight = await api?.updateWeight(payload);
      addToWeightHistory(weight!);
    } catch (e) {
      throw e.toString();
    }
  }

  void addWeight(payload) async {
    try {
      final weight = await api?.saveWeight(payload);
      addToWeightHistory(weight!);
    } catch (e) {
      throw e.toString();
    }
  }
}

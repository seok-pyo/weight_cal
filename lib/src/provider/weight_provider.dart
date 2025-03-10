import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WeightProvider with ChangeNotifier {
  Map<DateTime, double> weights = {};

  void saveWeight(DateTime date, double weight) async {
    weights[date] = weight;
    var box = await Hive.openBox('weights');
    box.put(date.toString(), weight); // Hive에 데이터 저장
    notifyListeners();
  }

  Future<void> loadWeights() async {
    var box = await Hive.openBox('weights');
    for (var key in box.keys) {
      weights[DateTime.parse(key)] = box.get(key);
      print(weights[DateTime.parse(key)]);
    }
    notifyListeners();
  }
}

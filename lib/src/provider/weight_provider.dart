import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WeightProvider with ChangeNotifier {
  Map<String, double> weights = {};
  // 객체 내의 데이터 혹은 로컬 데이터도 provider로 제공되면 변화를 감지해서 반영한다.
  final Box _box;

  WeightProvider(this._box);

  void saveWeight(DateTime date, double weight) async {
    String dateKey = formatDateKey(date);
    weights[dateKey] = weight;
    var box = await Hive.openBox('weights');
    box.put(dateKey, weight); // Hive에 데이터 저장
    notifyListeners();
  }

  void deleteWeight(DateTime date) async {
    String dateKey = formatDateKey(date);
    var box = await Hive.openBox('weights');
    await box.delete(dateKey);
    notifyListeners();
  }

  // Future<void> loadWeights() async {
  //   var box = await Hive.openBox('weights');
  //   for (var key in box.keys) {
  //     weights[DateTime.parse(key)] = box.get(key);
  //   }
  //   notifyListeners();
  // }

  double getWeight(DateTime date) {
    return _box.get(formatDateKey(date), defaultValue: 0.0);
  }

  String formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}

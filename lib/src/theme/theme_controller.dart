// 상태관리

import 'package:flutter/material.dart';
import 'package:vertical/src/theme/theme_service.dart';

class ThemeController extends ChangeNotifier {
  final ThemeService _themeService;
  late ThemeMode _themeMode;

  ThemeController(this._themeService);

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _themeService.themeMode();
    notifyListeners();
  }

  Future<void> updateTheme(ThemeMode newThemeMode) async {
    if (_themeMode == newThemeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();
    await _themeService.updateThemeMode(newThemeMode);
  }
}

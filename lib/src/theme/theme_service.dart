// 테마 저장 및 불러오기

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeService {
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? 1;
    return ThemeMode.values[themeIndex];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', theme.index);
  }
}

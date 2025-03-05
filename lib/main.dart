import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weight_cal/src/provider/weight_provider.dart';
import 'package:weight_cal/src/theme/theme_controller.dart';
import 'package:weight_cal/src/theme/theme_service.dart';

import 'src/app.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  // final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  WidgetsFlutterBinding.ensureInitialized();

  // hive init
  await Hive.initFlutter();

  // theme
  final themeService = ThemeService();
  final themeController = ThemeController(themeService);

  await themeController.loadSettings();

  runApp(
    ChangeNotifierProvider(
        create: (_) => WeightProvider(),
        child: MyApp(themeController: themeController)),
  );
}

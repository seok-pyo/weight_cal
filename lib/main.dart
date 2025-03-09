import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weight_cal/src/provider/weight_provider.dart';
import 'package:weight_cal/src/theme/theme_controller.dart';
import 'package:weight_cal/src/theme/theme_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // hive init
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
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

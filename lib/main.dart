import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vertical/src/provider/weight_provider.dart';
import 'package:vertical/src/theme/theme_controller.dart';
import 'package:vertical/src/theme/theme_service.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // hive init
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.initFlutter();
  final box = await Hive.openBox('weights');

  // theme
  final themeService = ThemeService();
  final themeController = ThemeController(themeService);

  await themeController.loadSettings();

  runApp(
    ChangeNotifierProvider(
      create: (_) => WeightProvider(box),
      child: MyApp(
        themeController: themeController,
      ),
    ),
  );
}

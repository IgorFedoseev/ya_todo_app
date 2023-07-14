import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ya_todo_list/flavors_config/config_provider.dart';
import 'package:ya_todo_list/flavors_config/todo_config.dart';
import 'package:ya_todo_list/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final config = TodoConfig(isTesting: false);
  runApp(
    ConfigProvider(
      config: config,
      child: MyApp(),
    ),
  );
}

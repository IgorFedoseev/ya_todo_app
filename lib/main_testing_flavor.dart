import 'di/locator.dart' as locator;
import 'package:flutter/material.dart';
import 'package:ya_todo_list/flavors_config/config_provider.dart';
import 'package:ya_todo_list/flavors_config/todo_config.dart';
import 'package:ya_todo_list/my_app.dart';

Future<void> main() async {
  locator.setupLocator();
  final config = TodoConfig(isTesting: true);
  runApp(
    ConfigProvider(
      config: config,
      child: MyApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'localizations/localizations.dart';
import 'navigation/router_delegate.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

//TODO: update readme and apk - send the link on homework page!!!

//TODO: update readme and apk

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routerDelegate = TodoRouterDelegate();

  @override
  Widget build(BuildContext context) {
    final theme = TodoTheme.light();
    final darkTheme = TodoTheme.dark();
    return MaterialApp.router(
      localizationsDelegates: TodoLocalization.localizationsDelegates,
      supportedLocales: TodoLocalization.locales,
      title: 'Todo list',
      darkTheme: darkTheme,
      theme: theme,
      routerDelegate: _routerDelegate,
    );
  }
}

import 'package:flutter/material.dart';
import 'localizations/localizations.dart';
import 'navigation/router_delegate.dart';
import 'theme/app_theme.dart';

// TODO: Readme & APK!!!

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

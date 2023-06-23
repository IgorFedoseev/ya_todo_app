import 'package:flutter/material.dart';
import 'localizations/localizations.dart';
import 'provider_widgets/main_screen_provider_widget.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TodoTheme.light();
    final darkTheme = TodoTheme.dark();
    return MaterialApp(
      localizationsDelegates: TodoLocalization.localizationsDelegates,
      supportedLocales: TodoLocalization.locales,
      title: 'Todo list',
      darkTheme: darkTheme,
      theme: theme,
      home: const MainScreenProviderWidget(),
    );
  }
}

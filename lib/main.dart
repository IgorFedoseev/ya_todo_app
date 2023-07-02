import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'localizations/localizations.dart';
import 'provider_widgets/main_screen_provider_widget.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

//TODO: update readme and apk
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

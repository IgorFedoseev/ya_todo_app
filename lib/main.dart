import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'routes/todo_routes.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final routes = TodoRoutesNames.getRoutes(context);
    final theme = TodoTheme.light();
    final darkTheme = TodoTheme.dark();
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      theme: theme,
      home: const MainScreenProviderWidget(),
      // routes: routes,
      // initialRoute: TodoRoutesNames.mainRoute,
    );
  }
}

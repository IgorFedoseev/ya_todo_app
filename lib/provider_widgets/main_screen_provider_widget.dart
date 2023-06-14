import 'package:flutter/material.dart';
import '../model/task_manager.dart';
import '../provider/task_provider.dart';
import '../screens/main_screen.dart';

class MainScreenProviderWidget extends StatefulWidget {
  const MainScreenProviderWidget({super.key});

  @override
  State<MainScreenProviderWidget> createState() =>
      _MainScreenProviderWidgetState();
}

class _MainScreenProviderWidgetState extends State<MainScreenProviderWidget> {
  final _model = TaskManager();

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      model: _model,
      child: const MainScreenWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/task_item.dart';
import '../model/task_manager.dart';
import '../provider/task_provider.dart';
import '../screens/main_screen.dart';

class MainScreenProviderWidget extends StatefulWidget {
  const MainScreenProviderWidget(
      {super.key, required this.editTask, required this.createTask});

  final void Function({
    required TaskItem item,
    required Function(TaskItem) onCreate,
    required Function(TaskItem) onUpdate,
    required Function onDelete,
  }) editTask;

  final void Function({
    required Function(TaskItem) onCreate,
    required Function(TaskItem) onUpdate,
    required Function onDelete,
  }) createTask;

  @override
  State<MainScreenProviderWidget> createState() =>
      _MainScreenProviderWidgetState();
}

class _MainScreenProviderWidgetState extends State<MainScreenProviderWidget> {
  late final TaskManager _model;

  @override
  void initState() {
    super.initState();
    _model = TaskManager(
      createTask: widget.createTask,
      editTask: widget.editTask,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      model: _model,
      child: const MainScreenWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/task_manager.dart';

class TaskProvider extends InheritedNotifier<TaskManager> {
  final TaskManager model;

  const TaskProvider({
    required super.child,
    required this.model,
    super.key,
  }) : super(notifier: model);

  static TaskManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>()?.model;
  }

  static TaskManager? getModel(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<TaskProvider>()?.widget;
    final model = widget is TaskProvider ? widget.notifier : null;
    return model;
  }
}

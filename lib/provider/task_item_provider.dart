import 'package:flutter/material.dart';

import '../model/task_item_manager.dart';

class TaskItemProvider extends InheritedNotifier<TaskItemManager> {
  final TaskItemManager model;

  const TaskItemProvider({
    required super.child,
    required this.model,
    super.key,
  }) : super(notifier: model);

  static TaskItemManager? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskItemProvider>()
        ?.model;
  }

  static TaskItemManager? getModel(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskItemProvider>()
        ?.widget;
    final model = widget is TaskItemProvider ? widget.notifier : null;
    return model;
  }
}

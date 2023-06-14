import 'package:flutter/material.dart';

import '../model/task_item.dart';
import '../model/task_item_manager.dart';
import '../provider/task_item_provider.dart';
import '../screens/task_item_screen.dart';

class TaskItemScreenProviderWidget extends StatefulWidget {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  final Function onDelete;
  final TaskItem? existingTask;
  const TaskItemScreenProviderWidget({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    required this.onDelete,
    this.existingTask,
  });

  @override
  State<TaskItemScreenProviderWidget> createState() =>
      _TaskItemScreenProviderWidgetState();
}

class _TaskItemScreenProviderWidgetState
    extends State<TaskItemScreenProviderWidget> {
  late final TaskItemManager _model;

  @override
  void initState() {
    super.initState();
    final task = widget.existingTask;
    final isTaskExist = task != null;
    _model = TaskItemManager(
      existingTask: task,
      isUpdateing: isTaskExist,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TaskItemProvider(
      model: _model,
      child: TaskItemScreenWidget(
        onCreate: widget.onCreate,
        onUpdate: widget.onUpdate,
        onDelete: widget.onDelete,
      ),
    );
  }
}

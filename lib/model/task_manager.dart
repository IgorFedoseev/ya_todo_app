import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';

import '../screens/task_item_screen.dart';

class TaskManager extends ChangeNotifier {
  final _allTasksList = <TaskItem>[];

  void addButtonOnPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskItemScreenProviderWidget(
          onCreate: (item) {
            addTask(item);
            Navigator.pop(context);
          },
          onUpdate: (item) {},
          onDelete: () => Navigator.pop(context),
        ),
      ),
    );
  }

  List<TaskItem> get allTasks => List.unmodifiable(_allTasksList);
  List<TaskItem> get outstandingTasks {
    final outstandingTasksList =
        _allTasksList.where((task) => task.isDone == false).toList();
    return List.unmodifiable(outstandingTasksList);
  }

  void onTaskComplete(int index) {
    final task = _allTasksList[index];
    final isDoneChanged = !task.isDone;
    final completedTask = task.copyWith(isDone: isDoneChanged);
    _allTasksList[index] = completedTask;
    notifyListeners();
  }

  void addTask(TaskItem task) {
    _allTasksList.add(task);
    notifyListeners();
  }

  void updateTask(TaskItem task, int index) {
    _allTasksList[index] = task;
    notifyListeners();
  }

  bool removeTask(int index) {
    _allTasksList.removeAt(index);
    notifyListeners();
    return true;
  }
}

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

  void addTask(TaskItem task) {
    _allTasksList.add(task);
    notifyListeners();
  }

  void completeTask(int index) {
    // when you swipe to the right, the value of isDone changes to the opposite
    final task = _allTasksList[index];
    final isDoneChanged = !task.isDone;
    _allTasksList[index] = task.copyWith(isDone: isDoneChanged);
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

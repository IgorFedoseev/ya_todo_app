import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';

class TaskManager extends ChangeNotifier {
  final _allTasksList = <TaskItem>[];
  bool _isVisibleCompleted = true;

  bool get isVisibleCompleted => _isVisibleCompleted;

  List<TaskItem> get allTasks {
    if (_isVisibleCompleted) {
      return List.unmodifiable(_allTasksList);
    } else {
      final outstandingTasksList =
          _allTasksList.where((task) => task.isDone == false).toList();
      return List.unmodifiable(outstandingTasksList);
    }
  }

  void onVisible() {
    _isVisibleCompleted = !_isVisibleCompleted;
    notifyListeners();
  }

  void addTask(TaskItem task) {
    _allTasksList.add(task);
    notifyListeners();
  }

  void onTaskComplete(TaskItem task) {
    final taskId = task.id;
    for (var i = 0; i < _allTasksList.length; i++) {
      if (_allTasksList[i].id == taskId) {
        final isDoneChanged = !task.isDone;
        final completedTask = task.copyWith(isDone: isDoneChanged);
        _allTasksList[i] = completedTask;
        break;
      }
    }
    notifyListeners();
  }

  void updateTask(TaskItem task) {
    final taskId = task.id;
    for (var i = 0; i < _allTasksList.length; i++) {
      if (_allTasksList[i].id == taskId) {
        _allTasksList[i] = task;
        break;
      }
    }
    notifyListeners();
  }

  bool removeTask(TaskItem task) {
    final taskId = task.id;
    for (var i = 0; i < _allTasksList.length; i++) {
      if (_allTasksList[i].id == taskId) {
        _allTasksList.removeAt(i);
        break;
      }
    }
    notifyListeners();
    return true;
  }
}

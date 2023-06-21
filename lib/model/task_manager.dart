import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';

import 'domain/api_clients.dart';

class TaskManager extends ChangeNotifier {
  final apiClient = ApiClient();
  List _allTasksList = <TaskItem>[];
  bool _isVisibleCompleted = true;
  int _revision = 0;

  void refreshData() async {
    final jsonData = await apiClient.getData();
    final tasksJson = jsonData['list'] as List;
    final tasksList = tasksJson.map((e) => TaskItem.fromJson(e)).toList();
    _allTasksList = tasksList;
    _revision = jsonData['revision'];
    notifyListeners();
  }

  bool get isVisibleCompleted => _isVisibleCompleted;

  int get completedTasksNumber {
    int counter = 0;
    for (var i = 0; i < _allTasksList.length; i++) {
      if (_allTasksList[i].isDone == true) {
        counter++;
      }
    }
    return counter;
  }

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
    apiClient.addTask(_revision, task);
    refreshData();
    // _allTasksList.add(task);
    // notifyListeners();
  }

  void onTaskComplete(TaskItem task) {
    final taskId = task.id;
    for (var i = 0; i < _allTasksList.length; i++) {
      if (_allTasksList[i].id == taskId) {
        final isDoneChanged = !task.isDone;
        final timeNow = DateTime.now().microsecondsSinceEpoch;
        final completedTask = task.copyWith(
          isDone: isDoneChanged,
          changedAt: timeNow,
        );
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

import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';
import '../repository/task_repository.dart';

class TaskManager extends ChangeNotifier {
  TaskManager({required this.createTask, required this.editTask});
  final _repository = TasksRepository();
  List _allTasksList = <TaskItem>[];
  bool _isVisibleCompleted = true;
  bool _offlineMode = false;

  bool get offlineMode => _offlineMode;

  List<TaskItem> get allTasks {
    _allTasksList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (_isVisibleCompleted) {
      return List.unmodifiable(_allTasksList);
    } else {
      final outstandingTasksList =
          _allTasksList.where((task) => task.isDone == false).toList();
      return List.unmodifiable(outstandingTasksList);
    }
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

  void onVisible() {
    _isVisibleCompleted = !_isVisibleCompleted;
    notifyListeners();
  }

  Future<void> refreshData() async {
    _allTasksList = await _repository.getTaskList();
    _offlineMode = _repository.offlineMode;
    notifyListeners();
  }

  Future<void> addTask(TaskItem task) async {
    await _repository.addTask(task);
    refreshData();
  }

  Future<void> onTaskComplete(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final isDoneChanged = !task.isDone;
    final changedTask = task.copyWith(
      isDone: isDoneChanged,
      changedAt: timeNow,
    );
    await _repository.completeTask(changedTask);
    refreshData();
  }

  Future<void> updateTask(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final changedTask = task.copyWith(changedAt: timeNow);
    await _repository.updateTask(changedTask);
    refreshData();
  }

  Future<bool> removeTask(TaskItem task) async {
    final taskId = task.id;
    await _repository.deleteTask(taskId);
    refreshData();
    return true;
  }

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
}

import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';
import 'dart:convert';
import '../storage/db_hive.dart';
import '../storage/shared_prefs_storage.dart';
import 'domain/api_clients.dart';

class TaskManager extends ChangeNotifier {
  // TODO: replace to repository
  final _dbHiveClient = HiveDataBase();
  // final _apiClient = ApiClient();
  final _dbClient = SharedPrefsStorage();
  List _allTasksList = <TaskItem>[];
  bool _isVisibleCompleted = true;
  int _backendRevision = 0;
  bool _offlineMode = false;

  bool get offlineMode => _offlineMode;

  List<TaskItem> get allTasks {
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
    // late String jsonData;
    // try {
    //   jsonData = await _apiClient.getData();
    //   _offlineMode = false;
    // } catch (e) {
    //   jsonData = await _dbClient.readData();
    //   _offlineMode = true;
    // }
    // final json = jsonDecode(jsonData) as Map<String, dynamic>;
    // final tasksJson = json['list'] as List;
    // final tasksList = tasksJson.map((e) => TaskItem.fromJson(e)).toList();

    // TODO: delete tasks from hive
    final tasksHive = await _dbHiveClient.getTasks();
    _allTasksList = tasksHive;
    print(_allTasksList);
    notifyListeners();
    // _backendRevision = json['revision'] ?? _backendRevision;
    // _dbClient.setData(jsonData);
  }

  Future<void> addTask(TaskItem task) async {
    // try {
    //   await _apiClient.addTask(_backendRevision, task);
    //   refreshData();
    // } catch (e) {
    //   _offlineMode = true;
    //   notifyListeners();
    // }
    // TODO: replace to repository
    _dbHiveClient.putTask(task);
    refreshData();
  }

  Future<void> onTaskComplete(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final isDoneChanged = !task.isDone;
    final changedTask = task.copyWith(
      isDone: isDoneChanged,
      changedAt: timeNow,
    );
    // try {
    //   await _apiClient.editTask(_backendRevision, changedTask);
    //   refreshData();
    // } catch (e) {
    //   _offlineMode = true;
    //   notifyListeners();
    // }
    await _dbHiveClient.putTask(changedTask);
    refreshData();
  }

  Future<void> updateTask(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final changedTask = task.copyWith(changedAt: timeNow);
    // try {
    //   await _apiClient.editTask(_backendRevision, changedTask);
    //   refreshData();
    // } catch (e) {
    //   _offlineMode = true;
    //   notifyListeners();
    // }
    await _dbHiveClient.putTask(changedTask);
    refreshData();
  }

  Future<bool> removeTask(TaskItem task) async {
    final taskId = task.id;
    // try {
    //   await _apiClient.deleteTask(_backendRevision, taskId);
    //   refreshData();
    // } catch (e) {
    //   _offlineMode = true;
    //   notifyListeners();
    // }
    await _dbHiveClient.deleteTask(taskId);
    refreshData();
    return true;
  }
}

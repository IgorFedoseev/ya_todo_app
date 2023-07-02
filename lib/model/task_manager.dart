import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';
import '../storage/db_hive.dart';
import '../storage/shared_prefs_storage.dart';
import '../domain/api_clients.dart';

class TaskManager extends ChangeNotifier {
  // TODO: replace to repository
  final _dbHiveClient = HiveDataBase();
  final _apiClient = ApiClient();
  final _dbClient = SharedPrefsStorage();

  int _backendRevision = 0;
  int _dataBaseRevision = 0;

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
    final tasksHive = await _dbHiveClient.getTasks();
    _allTasksList = tasksHive;
    notifyListeners();
    _dataBaseRevision = await _dbClient.getRevision();
    print(_dataBaseRevision);
    try {
      final json = await _apiClient.getData();
      if (_offlineMode) {
        _offlineMode = false;
      }
      final revision = json['revision'] as int;
      _backendRevision = revision;
      if (_backendRevision > _dataBaseRevision) {
        final tasksJson = json['list'] as List;
        final tasksBackend =
            tasksJson.map((e) => TaskItem.fromJson(e)).toList();
        for (var task in tasksBackend) {
          _dbHiveClient.putTask(task);
        }
        _dbClient.setRevision(_backendRevision);
        if (tasksBackend.length < tasksHive.length) {
          // TODO:// separated deleting method
          final backendIdSet = <String>{};
          final hiveIdSet = <String>{};
          for (var bTask in tasksBackend) {
            backendIdSet.add(bTask.id);
          }
          for (var hTask in tasksHive) {
            hiveIdSet.add(hTask.id);
          }
          final idSetForDeleting = hiveIdSet.difference(backendIdSet);
          for (var taskId in idSetForDeleting) {
            _dbHiveClient.deleteTask(taskId);
          }
          final changedList = await _dbHiveClient.getTasks();
          _allTasksList = changedList;
          notifyListeners();
        }
      } else if (_backendRevision < _dataBaseRevision) {
        try {
          _apiClient.patchTasks(_backendRevision, tasksHive);
          _backendRevision++;
          _dataBaseRevision = _backendRevision;
        } catch (e) {
          print('data hasn\'t been saved');
          _offlineMode = true;
        }
      }
    } catch (e) {
      _offlineMode = true;
    }
  }

  Future<void> addTask(TaskItem task) async {
    _dbHiveClient.putTask(task);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.addTask(_backendRevision, task);
      print('well added');
    } catch (e) {
      _offlineMode = true;
      notifyListeners();
      print('Hasn\'t been added');
    }
    refreshData();
  }

  Future<void> onTaskComplete(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final isDoneChanged = !task.isDone;
    final changedTask = task.copyWith(
      isDone: isDoneChanged,
      changedAt: timeNow,
    );
    _dbHiveClient.putTask(changedTask);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.editTask(_backendRevision, changedTask);
    } catch (e) {
      _offlineMode = true;
      notifyListeners();
    }
    refreshData();
  }

  Future<void> updateTask(TaskItem task) async {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final changedTask = task.copyWith(changedAt: timeNow);
    _dbHiveClient.putTask(changedTask);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.editTask(_backendRevision, changedTask);
    } catch (e) {
      _offlineMode = true;
      notifyListeners();
    }
    refreshData();
  }

  Future<bool> removeTask(TaskItem task) async {
    final taskId = task.id;
    _dbHiveClient.deleteTask(taskId);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.deleteTask(_backendRevision, taskId);
    } catch (e) {
      _offlineMode = true;
      notifyListeners();
    }
    refreshData();
    return true;
  }
}

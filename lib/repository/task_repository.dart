import '../model/task_item.dart';
import '../storage/db_hive.dart';
import '../storage/shared_prefs_storage.dart';
import '../domain/api_clients.dart';

class TasksRepository {
  final _dbHiveClient = HiveDataBase();
  final _apiClient = ApiClient();
  final _dbClient = SharedPrefsStorage();

  int _backendRevision = 0;
  int _dataBaseRevision = 0;

  bool _offlineMode = false;
  bool get offlineMode => _offlineMode;

  Future<void> addTask(TaskItem task) async {
    _dbHiveClient.putTask(task);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.addTask(_backendRevision, task);
    } catch (e) {
      _offlineMode = true;
    }
  }

  Future<void> completeTask(TaskItem changedTask) async {
    _dbHiveClient.putTask(changedTask);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.editTask(_backendRevision, changedTask);
    } catch (e) {
      _offlineMode = true;
    }
  }

  Future<void> updateTask(TaskItem changedTask) async {
    _dbHiveClient.putTask(changedTask);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.editTask(_backendRevision, changedTask);
    } catch (e) {
      _offlineMode = true;
    }
  }

  Future<void> deleteTask(String taskId) async {
    _dbHiveClient.deleteTask(taskId);
    _dbClient.setRevision(_dataBaseRevision + 1);
    try {
      await _apiClient.deleteTask(_backendRevision, taskId);
    } catch (e) {
      _offlineMode = true;
    }
  }

  Future<List<TaskItem>> getTaskList() async {
    // Test without internet and in postman 1moretime
    _dataBaseRevision = await _dbClient.getRevision();
    final tasksHive = await _dbHiveClient.getTasks();
    try {
      final json = await _apiClient.getData();
      if (_offlineMode) {
        _offlineMode = false;
      }
      final backRevision = json['revision'] as int;
      _backendRevision = backRevision;
      if (_backendRevision > _dataBaseRevision) {
        final tasksJson = json['list'] as List;
        final tasksBack = tasksJson.map((e) => TaskItem.fromJson(e)).toList();
        for (var task in tasksBack) {
          _dbHiveClient.putTask(task);
        }
        _dbClient.setRevision(_backendRevision);
        if (tasksBack.length < tasksHive.length) {
          final changedList = await _deleteRemovedData(tasksBack, tasksHive);
          return changedList;
        }
        final supplementedTasks = await _dbHiveClient.getTasks();
        return supplementedTasks;
      } else if (_backendRevision < _dataBaseRevision) {
        // Здесь происходит обновление данных на удаленном сервере
        // после возобновления интернет-соединения
        // если в режиме оффлайн были внесены изменения в список
        try {
          await _apiClient.patchTasks(_backendRevision, tasksHive);
          _backendRevision++;
          _dbClient.setRevision(_backendRevision);
        } catch (e) {
          _offlineMode = true;
        }
      }
    } catch (e) {
      _offlineMode = true;
    }
    return tasksHive;
  }

  Future<List<TaskItem>> _deleteRemovedData(
    List<TaskItem> tasksBackend,
    List<TaskItem> tasksHive,
  ) async {
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
    return changedList;
  }
}

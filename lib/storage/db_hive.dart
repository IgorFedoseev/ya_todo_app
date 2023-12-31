import 'package:hive/hive.dart';

import '../model/task_item.dart';

class HiveDataBase {
  Future<void> putTask(TaskItem task) async {
    final box = await _registerAdapters<TaskItem>('task_box');
    await box.put(task.id, task);
    box.close();
  }

  Future<List<TaskItem>> getTasks() async {
    final box = await _registerAdapters<TaskItem>('task_box');
    final tasks = box.values.toList();
    box.close();
    return tasks;
  }

  Future<void> deleteTask(String id) async {
    final box = await _registerAdapters<TaskItem>('task_box');
    await box.delete(id);
    // await box.compact();
    box.close();
  }

  Future<Box<T>> _registerAdapters<T>(String boxName) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskItemAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ImportanceAdapter());
    }
    final box = await Hive.openBox<T>(boxName);
    return box;
  }
}

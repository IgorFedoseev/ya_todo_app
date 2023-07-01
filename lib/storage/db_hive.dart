import 'package:hive/hive.dart';

import '../model/task_item.dart';

class HiveDataBase {
  Future<void> addTask(TaskItem task) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskItemAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ImportanceAdapter());
    }
    final box = await Hive.openBox<TaskItem>('task_box');
    await box.add(task);
  }

  Future<List<TaskItem>> getTasks() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskItemAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ImportanceAdapter());
    }
    final box = await Hive.openBox<TaskItem>('task_box');
    final tasks = box.values.toList();
    return tasks;
  }
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../theme/random_color_creater.dart';
import 'task_item.dart';

class TaskItemManager extends ChangeNotifier {
  TaskItemManager({required this.existingTask, required this.isUpdateing}) {
    _taskTitle = existingTask?.title;
    _taskDate = existingTask?.date;
    _taskImportance = existingTask?.importance;
    setTaskImportanceText();
  }
  String? _taskTitle;
  DateTime? _taskDate;
  Importance? _taskImportance;
  String _taskImportanceText = 'Нет';
  final TaskItem? existingTask;
  final bool isUpdateing;

  set taskTitle(String taskInputText) {
    _taskTitle = taskInputText;
    notifyListeners();
  }

  String get taskTitle => _taskTitle ?? '';

  set taskDate(DateTime? taskDate) {
    _taskDate = taskDate;
    notifyListeners();
  }

  DateTime? get taskDate => _taskDate;

  set taskImportance(Importance? importance) {
    _taskImportance = importance;
    setTaskImportanceText();
    notifyListeners();
  }

  Importance? get taskImportance => _taskImportance;

  get taskImportanceText => _taskImportanceText;

  void setTaskImportanceText() {
    final importance = _taskImportance;
    switch (importance) {
      case Importance.high:
        _taskImportanceText = '!! Высокий';
        break;
      case Importance.low:
        _taskImportanceText = 'Низкий';
        break;
      default:
        _taskImportanceText = 'Нет';
    }
  }

  TaskItem createTask(String deviceId) {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final task = TaskItem(
      id: existingTask?.id ?? const Uuid().v1(),
      title: _taskTitle ?? '_',
      date: _taskDate,
      importance: _taskImportance ?? Importance.no,
      isDone: existingTask?.isDone ?? false,
      stringColor: existingTask?.stringColor ?? RandomColor.getColor,
      createdAt: existingTask?.createdAt ?? timeNow,
      changedAt: timeNow,
      lastUpdatedBy: deviceId,
    );
    return task;
  }
}

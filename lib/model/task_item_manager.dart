import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'task_item.dart';

class TaskItemManager extends ChangeNotifier {
  String? _taskTitle;

  set taskTitle(String taskInputText) {
    _taskTitle = taskInputText;
    notifyListeners();
  }

  String get taskTitle => _taskTitle ?? '';

  // Function? get onPressedDeleteButton {
  //   final taskText = _taskTitle;
  //   if (taskText != null && taskText.trim().isNotEmpty) {
  //     return _onPressedDeleteButton;
  //   } else {
  //     return null;
  //   }
  // }

  void onPressedDeleteButton() {
    print(_taskTitle);
  }

  void onPressedSaveButton() {
    final task = TaskItem(id: const Uuid().v1(), title: _taskTitle ?? '_');
    print(task.id);
  }
}

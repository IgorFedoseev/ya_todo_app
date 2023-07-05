import '../model/task_item.dart';

class NavigationState {
  final bool? _isUnknown;
  final bool? _isTaskScreen;
  TaskItem? selectedTask;

  bool get isNewTaskScreen => _isTaskScreen == true && selectedTask == null;
  bool get isEditTaskScreen => _isTaskScreen == true && selectedTask != null;
  bool get isUnknown => _isUnknown == true;
  bool get isMain => !isUnknown && !isNewTaskScreen && !isEditTaskScreen;

  NavigationState.main()
      : _isUnknown = false,
        _isTaskScreen = false,
        selectedTask = null;

  NavigationState.newTask()
      : _isUnknown = false,
        _isTaskScreen = true,
        selectedTask = null;

  NavigationState.editTask(this.selectedTask)
      : _isUnknown = false,
        _isTaskScreen = true;

  NavigationState.unknown()
      : _isUnknown = true,
        _isTaskScreen = false,
        selectedTask = null;
}

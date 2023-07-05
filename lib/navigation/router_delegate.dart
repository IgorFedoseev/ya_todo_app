import 'package:flutter/material.dart';
import 'package:ya_todo_list/navigation/navigation_state.dart';

import '../model/task_item.dart';
import '../provider_widgets/main_screen_provider_widget.dart';
import '../provider_widgets/task_item_provider_widget.dart';

class TodoRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  NavigationState? state;

  void emptyFunction(TaskItem item) {}

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  TodoRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: MainScreenProviderWidget(
            createTask: _createTask,
            editTask: _editTask,
          ),
        ),
        if (state?.isNewTaskScreen == true)
          MaterialPage(
            child: TaskItemScreenProviderWidget(
              onCreate: state?.onCreate ?? emptyFunction,
              onUpdate: state?.onUpdate ?? emptyFunction,
              onDelete: state?.onDelete ?? () {},
            ),
          ),
        if (state?.isEditTaskScreen == true)
          MaterialPage(
            child: TaskItemScreenProviderWidget(
              existingTask: state?.selectedTask,
              onCreate: state?.onCreate ?? emptyFunction,
              onUpdate: state?.onUpdate ?? emptyFunction,
              onDelete: state?.onDelete ?? () {},
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        state = NavigationState.main();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void _editTask({
    required TaskItem item,
    required Function(TaskItem) onCreate,
    required Function(TaskItem) onUpdate,
    required Function onDelete,
  }) {
    state = NavigationState.editTask(item, onCreate, onUpdate, onDelete);
    notifyListeners();
  }

  void _createTask({
    required Function(TaskItem) onCreate,
    required Function(TaskItem) onUpdate,
    required Function onDelete,
  }) {
    state = NavigationState.newTask(onCreate, onUpdate, onDelete);
    notifyListeners();
  }
}

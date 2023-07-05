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
        const MaterialPage(
          child: MainScreenProviderWidget(),
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
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }
}

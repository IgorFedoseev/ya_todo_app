// import 'package:flutter/material.dart';
// // import '../model/task_manager.dart';
// // import '../screens/invalid_nav_screen.dart';
// import '../screens/main_screen.dart';
// import '../screens/task_item_screen.dart';

abstract class TodoRoutesNames {
  static const mainRoute = '/';
  static const taskItemRoute = '/task_item_route';

  // static Map<String, Widget Function(BuildContext context)> getRoutes(
  //     BuildContext context) {
  //   return {
  //     mainRoute: (context) => const MainScreenProviderWidget(),
  //     taskItemRoute: (context) {
  //       final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

  //       // return TaskItemScreenProviderWidget();
  //       // final manager = ModalRoute.of(context)?.settings.arguments;
  //       // if (manager is TaskManager) {
  //       //   return TaskItemScreenWidget(manager: manager);
  //       // }
  //       // return const InvalidNavigationScreenWidget();
  //     }
  //   };
  // }
}

import 'package:flutter/material.dart';
import '../model/task_item.dart';
import '../model/task_manager.dart';
import '../provider/task_provider.dart';
// import '../routes/todo_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MainScreenProviderWidget extends StatefulWidget {
  const MainScreenProviderWidget({super.key});

  @override
  State<MainScreenProviderWidget> createState() =>
      _MainScreenProviderWidgetState();
}

class _MainScreenProviderWidgetState extends State<MainScreenProviderWidget> {
  final _model = TaskManager();

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      model: _model,
      child: const MainScreenWidget(),
    );
  }
}

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = TaskProvider.of(context);
    final allTasks = manager?.allTasks ?? [];
    final taskListColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.backSecondary
        : LightThemeColors.backSecondary;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 5.0,
        shadowColor: DarkThemeColors.backElevated,
        title: const Text('Мои дела'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: taskListColor,
                border: Border.all(color: taskListColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = allTasks[index];
                      return TaskTile(
                        task: task,
                      );
                    },
                  ),
                  const NewTaskButtonTile(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => manager?.addButtonOnPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final TaskItem task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 14.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.square_outlined),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              task.title,
              style: AppTextStyles.listTextStyle,
            ),
          ),
          const SizedBox(width: 14),
          const Icon(Icons.info_outline),
        ],
      ),
    );
  }
}

class NewTaskButtonTile extends StatelessWidget {
  const NewTaskButtonTile({super.key});

  @override
  Widget build(BuildContext context) {
    final newButtonStyle = AppTextStyles.newTaskButtonStyle(context);
    final manager = TaskProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 14.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Opacity(opacity: 0.0, child: Icon(Icons.square_outlined)),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () => manager?.addButtonOnPressed(context),
              child: Text(
                'Новое',
                style: newButtonStyle,
              ),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
    );
  }
}

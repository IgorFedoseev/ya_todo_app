import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';
import '../provider/task_provider.dart';
import '../provider_widgets/task_item_provider_widget.dart';
import '../theme/app_colors.dart';
import 'main_screen_componentes/new_task_tile_widget.dart';
import 'main_screen_componentes/task_tile_widget.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = TaskProvider.of(context);
    final allTasks = manager?.allTasks ?? [];
    final taskListColor = TodoElementsColor.getBackSecondaryColor(context);
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
                      return TaskTile(
                        index: index,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskItemScreenProviderWidget(
                onCreate: (item) {
                  manager?.addTask(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
                onDelete: () => Navigator.pop(context),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

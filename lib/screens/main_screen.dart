import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';
import 'package:ya_todo_list/theme/app_text_styles.dart';
import '../provider/task_provider.dart';
import '../provider_widgets/task_item_provider_widget.dart';
import 'main_screen_componentes/completed_number_widget.dart';
import 'main_screen_componentes/new_task_tile_widget.dart';
import 'main_screen_componentes/task_tile_widget.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = TaskProvider.of(context);
    final allTasks = manager?.allTasks ?? [];
    final appBatTitleColor = TodoElementsColor.getLabelPrimaryColor(context);
    final appBarTitleStyle =
        AppTextStyles.appBarTextStyle.copyWith(color: appBatTitleColor);
    final taskListColor = TodoElementsColor.getBackSecondaryColor(context);
    final iconColor = TodoElementsColor.getBlueColor(context);
    final isVisibleCompleted = manager?.isVisibleCompleted ?? true;
    final visibleIcon =
        isVisibleCompleted ? Icons.visibility : Icons.visibility_off;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: TodoElementsColor.getBackPrimaryColor(context),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Мои дела', style: appBarTitleStyle),
            ),
            actions: [
              IconButton(
                onPressed: manager?.onVisible,
                icon: Icon(
                  visibleIcon,
                  color: iconColor,
                ),
              ),
            ],
            // bottom: PreferredSize(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(60.0, 16.0, 20.0, 16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(child: Text('Выполненные')),
            //         Icon(Icons.visibility),
            //       ],
            //     ),
            //   ),
            //   preferredSize: Size.zero,
            // ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CompletedNumberWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 40.0),
                  child: Container(
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
                          padding: EdgeInsets.zero,
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
                ),
              ],
            ),
          ),
        ],
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

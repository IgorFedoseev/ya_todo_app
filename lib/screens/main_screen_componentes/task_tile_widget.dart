import 'package:flutter/material.dart';
import 'package:ya_todo_list/model/task_item.dart';

import '../../provider/task_provider.dart';
import '../../theme/app_elements_color.dart';
import 'checkbox_widget.dart';
import 'completing_background_widget.dart';
import 'deleting_background_widget.dart';
import 'importance_mark_widget.dart';
import 'task_text_widget.dart';

class TaskTile extends StatelessWidget {
  final int index;
  const TaskTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = TaskProvider.of(context);
    final allTasks = manager?.allTasks ?? [];
    final task = allTasks[index];
    final isTaskCompleted = task.isDone;
    return Dismissible(
      key: Key(task.id),
      background: const CompletingBackgroundWidget(),
      secondaryBackground: const DeletingBackgroundWidget(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          manager?.removeTask(task);
        } else {
          manager?.onTaskComplete(task);
        }
        return false;
      },
      child: InkWell(
        onTap: () {
          return manager?.editTask(
            item: task,
            onCreate: (item) {},
            onUpdate: (item) {
              manager.updateTask(item);
              Navigator.pop(context);
            },
            onDelete: () {
              manager.removeTask(task);
              Navigator.pop(context);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 14.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CheckBoxIconWidget(task: task),
              ),
              const SizedBox(width: 14),
              if (!isTaskCompleted && task.importance != Importance.no)
                ImportanceMarkWidget(task: task),
              TaskTextWidget(task: task),
              const SizedBox(width: 14),
              SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.info_outline,
                  color: TodoElementsColor.getTertiaryColor(context),
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

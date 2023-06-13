import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';
import '../../model/task_item.dart';
import '../../theme/app_text_styles.dart';

class TaskTextWidget extends StatelessWidget {
  final TaskItem task;
  const TaskTextWidget({super.key, required this.task});

  Widget getImportanceMark(BuildContext context) {
    final isUrgent = task.importance == Importance.high;
    final redColor = TodoElementsColor.getRedColor(context);
    if (isUrgent) {
      return Text(' !! ',
          style: AppTextStyles.listTextStyle.copyWith(
              color: redColor, fontWeight: FontWeight.w900, fontSize: 22));
    } else {
      return Icon(
        Icons.arrow_downward,
        color: TodoElementsColor.getGreyColor(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTaskCompleted = task.isDone;
    final completedTextColor = TodoElementsColor.getTertiaryColor(context);
    final textRegularStyle = AppTextStyles.listTextStyle;
    final textCompletedStyle = AppTextStyles.listTextStyle.copyWith(
      color: completedTextColor,
      decoration: TextDecoration.lineThrough,
      decorationColor: completedTextColor,
    );
    final textStyle = isTaskCompleted ? textCompletedStyle : textRegularStyle;
    final taskTitle = task.title;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!isTaskCompleted && task.importance != null)
            getImportanceMark(context),
          Expanded(child: Text(taskTitle, style: textStyle)),
        ],
      ),
    );
  }
}

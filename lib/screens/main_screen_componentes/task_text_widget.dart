import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';
import '../../model/task_item.dart';
import '../../theme/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskTextWidget extends StatelessWidget {
  final TaskItem task;
  const TaskTextWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isTaskCompleted = task.isDone;
    final isDateSetted = task.date != null;
    final completedTextColor = TodoElementsColor.getTertiaryColor(context);
    final textRegularStyle = AppTextStyles.listTextStyle;
    final textCompletedStyle = AppTextStyles.listTextStyle.copyWith(
      color: completedTextColor,
      decoration: TextDecoration.lineThrough,
      decorationColor: completedTextColor,
    );
    final textStyle = isTaskCompleted ? textCompletedStyle : textRegularStyle;
    final taskTitle = task.title;
    final dateTextStyle =
        AppTextStyles.regylarBodyText.copyWith(color: completedTextColor);
    final dateMark = AppLocalizations.of(context)?.dateMark ?? '';
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(taskTitle, style: textStyle),
          if (isDateSetted && !isTaskCompleted)
            Text(dateMark, style: dateTextStyle),
        ],
      ),
    );
  }
}

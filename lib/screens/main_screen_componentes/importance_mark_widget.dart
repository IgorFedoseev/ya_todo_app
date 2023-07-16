import 'package:flutter/material.dart';
import '../../di/locator.dart';
import '../../model/task_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_text_styles.dart';

class ImportanceMarkWidget extends StatelessWidget {
  final TaskItem task;
  const ImportanceMarkWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final isUrgent = task.importance == Importance.high;
    final redColor = TodoElementsColor.getRedColor(context);
    final isConfigRemoteEnabled = Locator.remoteConfig.isColorChanged;
    final markColor =
        isConfigRemoteEnabled ? FirebaseColors.importanceColor : redColor;
    if (isUrgent) {
      return Text(' !! ',
          style: AppTextStyles.listTextStyle.copyWith(
              color: markColor, fontWeight: FontWeight.w900, fontSize: 22));
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 3.0),
          Icon(
            Icons.arrow_downward,
            color: TodoElementsColor.getGreyColor(context),
          ),
        ],
      );
    }
  }
}

import 'package:flutter/material.dart';
import '../../provider/task_provider.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_elements_text_styles.dart';

class CompletedNumberWidget extends StatelessWidget {
  const CompletedNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = TaskProvider.of(context);
    final completedNumber = manager?.completedTasksNumber ?? 0;
    final isVisibleCompleted = manager?.isVisibleCompleted ?? true;
    final visibleIcon =
        isVisibleCompleted ? Icons.visibility : Icons.visibility_off;
    final iconColor = TodoElementsColor.getBlueColor(context);
    final newButtonStyle = AppElementsTextStyles.newTaskButtonStyle(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 14.2, 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Opacity(opacity: 0.0, child: Icon(Icons.square_outlined)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              'Выполнено - $completedNumber',
              style: newButtonStyle,
            ),
          ),
          IconButton(
            onPressed: manager?.onVisible,
            icon: Icon(
              visibleIcon,
              color: iconColor,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

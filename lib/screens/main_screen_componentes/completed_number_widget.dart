import 'package:flutter/material.dart';
import '../../provider/task_provider.dart';
import '../../theme/app_elements_text_styles.dart';

class CompletedNumberWidget extends StatelessWidget {
  const CompletedNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final completedNumber = TaskProvider.of(context)?.completedTasksNumber ?? 0;
    final newButtonStyle = AppElementsTextStyles.newTaskButtonStyle(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 0.0, 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Opacity(opacity: 0.0, child: Icon(Icons.square_outlined)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              'Выполнено - $completedNumber',
              style: newButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}

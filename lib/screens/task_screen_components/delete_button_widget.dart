import 'package:flutter/material.dart';

import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_color.dart';

class DeleteButtonWidget extends StatelessWidget {
  final Function onDelete;
  const DeleteButtonWidget({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final taskTitle = manager?.taskTitle;
    final isTextFieldEmpty = taskTitle?.trim().isEmpty ?? true;
    final deleteButtonColor = TodoElementsColor.getRedColor(context);
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 200),
      child: TextButton(
        onPressed: isTextFieldEmpty ? null : () => onDelete(),
        style: TextButton.styleFrom(
          foregroundColor: deleteButtonColor,
        ),
        child: const Row(
          children: [
            Icon(Icons.delete),
            SizedBox(width: 10),
            Text('Удалить'),
          ],
        ),
      ),
    );
  }
}

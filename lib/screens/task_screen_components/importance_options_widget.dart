import 'package:flutter/material.dart';

import '../../model/task_item.dart';
import '../../model/task_item_manager.dart';
import 'importance_dialog_widget.dart';

class ImportanceOptionsWidget extends StatelessWidget {
  const ImportanceOptionsWidget({
    super.key,
    required this.manager,
  });

  final TaskItemManager? manager;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImportanceDialogOption(
            label: 'Нет',
            chooseImportance: () {
              manager?.taskImportance = null;
              Navigator.of(context).pop();
            },
          ),
          ImportanceDialogOption(
            label: 'Низкий',
            chooseImportance: () {
              manager?.taskImportance = Importance.low;
              Navigator.of(context).pop();
            },
          ),
          ImportanceDialogOption(
            label: 'Высокий',
            chooseImportance: () {
              manager?.taskImportance = Importance.high;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

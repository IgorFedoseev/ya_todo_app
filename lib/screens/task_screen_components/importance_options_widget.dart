import 'package:flutter/material.dart';

import '../../model/task_item.dart';
import '../../model/task_item_manager.dart';
import 'importance_dialog_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportanceOptionsWidget extends StatelessWidget {
  const ImportanceOptionsWidget({
    super.key,
    required this.manager,
  });

  final TaskItemManager? manager;

  @override
  Widget build(BuildContext context) {
    final noText = AppLocalizations.of(context)?.importance_no ?? '';
    final lowText = AppLocalizations.of(context)?.importance_low ?? '';
    final highText = AppLocalizations.of(context)?.importance_high ?? '';
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImportanceDialogOption(
            label: noText,
            chooseImportance: () {
              manager?.taskImportance = null;
              Navigator.of(context).pop();
            },
          ),
          ImportanceDialogOption(
            label: lowText,
            chooseImportance: () {
              manager?.taskImportance = Importance.low;
              Navigator.of(context).pop();
            },
          ),
          ImportanceDialogOption(
            label: highText,
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

import 'package:flutter/material.dart';

import '../../model/task_item.dart';
import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_text_styles.dart';
import '../../theme/app_text_styles.dart';
import 'importance_options_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportanceWidget extends StatelessWidget {
  const ImportanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final labelText = AppLocalizations.of(context)?.importance_title ?? '';
    final noText = AppLocalizations.of(context)?.importance_no ?? '';
    final manager = TaskItemProvider.of(context);
    final isHighImportance = manager?.taskImportance == Importance.high;
    final importanceText =
        TaskItemProvider.of(context)?.taskImportanceText ?? noText;
    final smallTextStyle = isHighImportance
        ? AppElementsTextStyles.highValueStyle(context)
        : AppElementsTextStyles.lowValueStyle(context);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              insetPadding:
                  const EdgeInsets.only(bottom: 180, right: 180, left: 16),
              child: ImportanceOptionsWidget(manager: manager),
            );
          }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: AppTextStyles.regylarBodyText),
          const SizedBox(height: 4.0),
          Text(importanceText, style: smallTextStyle),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

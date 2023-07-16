import 'package:flutter/material.dart';

import '../../di/locator.dart';
import '../../model/task_item.dart';
import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_text_styles.dart';
import '../../theme/app_text_styles.dart';
import 'importance_options_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportanceWidget extends StatelessWidget {
  const ImportanceWidget({super.key});

  String _setTaskImportanceText(BuildContext context, Importance? importance) {
    switch (importance) {
      case Importance.high:
        return AppLocalizations.of(context)?.importance_high ?? '';
      case Importance.low:
        return AppLocalizations.of(context)?.importance_low ?? '';
      default:
        return AppLocalizations.of(context)?.importance_no ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelText = AppLocalizations.of(context)?.importance_title ?? '';
    final manager = TaskItemProvider.of(context);
    final importance = manager?.taskImportance;
    final isHighImportance = manager?.taskImportance == Importance.high;
    final importanceText = _setTaskImportanceText(context, importance);
    final isConfigRemoteEnabled = Locator.remoteConfig.isColorChanged;
    final smallTextStyle = isHighImportance
        ? AppElementsTextStyles.highValueStyle(context, isConfigRemoteEnabled)
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

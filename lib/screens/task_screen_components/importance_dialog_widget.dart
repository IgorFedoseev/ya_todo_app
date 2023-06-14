import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';

class ImportanceDialogOption extends StatelessWidget {
  final String label;
  final Function chooseImportance;
  const ImportanceDialogOption(
      {super.key, required this.chooseImportance, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => chooseImportance(),
      child: SizedBox(
        height: 48,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                    child: Text(label, style: AppTextStyles.regylarBodyText)),
              ],
            )),
      ),
    );
  }
}

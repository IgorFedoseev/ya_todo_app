import 'package:flutter/material.dart';

import '../../provider/task_provider.dart';
import '../../theme/app_elements_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTaskButtonTile extends StatelessWidget {
  const NewTaskButtonTile({super.key});

  @override
  Widget build(BuildContext context) {
    final newButtonStyle = AppElementsTextStyles.newTaskButtonStyle(context);
    final manager = TaskProvider.getModel(context);
    final tileText = AppLocalizations.of(context)?.new_task ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 14.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Opacity(opacity: 0.0, child: Icon(Icons.square_outlined)),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                return manager?.createTask(
                  onCreate: (item) {
                    manager.addTask(item);
                    Navigator.pop(context);
                  },
                  onUpdate: (item) {},
                  onDelete: () => Navigator.pop(context),
                );
              },
              child: Text(
                tileText,
                style: newButtonStyle,
              ),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
    );
  }
}

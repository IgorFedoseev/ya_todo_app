import 'package:flutter/material.dart';

import '../../provider/task_provider.dart';
import '../../provider_widgets/task_item_provider_widget.dart';
import '../../theme/app_elements_text_styles.dart';

class NewTaskButtonTile extends StatelessWidget {
  const NewTaskButtonTile({super.key});

  @override
  Widget build(BuildContext context) {
    final newButtonStyle = AppElementsTextStyles.newTaskButtonStyle(context);
    final manager = TaskProvider.getModel(context);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskItemScreenProviderWidget(
                      onCreate: (item) {
                        manager?.addTask(item);
                        Navigator.pop(context);
                      },
                      onUpdate: (item) {},
                      onDelete: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
              child: Text(
                'Новое',
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

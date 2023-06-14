import 'package:flutter/material.dart';
import '../model/task_item.dart';
import '../model/task_item_manager.dart';
import '../provider/task_item_provider.dart';
import '../theme/app_elements_text_styles.dart';
import 'task_screen_components/date_picker_widget.dart';
import 'task_screen_components/delete_button_widget.dart';
import 'task_screen_components/importance_selection_widget.dart';
import 'task_screen_components/separator_widget.dart';
import 'task_screen_components/task_field_widget.dart';

class TaskItemScreenWidget extends StatelessWidget {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  final Function onDelete;
  const TaskItemScreenWidget({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    required this.onDelete,
  });

  void onSavePressed(TaskItemManager? manager) {
    if (manager is TaskItemManager) {
      final task = manager.createTask();
      final isTaskUpdated = manager.isUpdateing;
      if (isTaskUpdated) {
        onUpdate(task);
      } else {
        onCreate(task);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final taskTitle = manager?.taskTitle;
    final isTextFieldEmpty = taskTitle?.trim().isEmpty ?? true;
    final appBarButtonStyle = AppElementsTextStyles.textButtonStyle(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: isTextFieldEmpty ? null : () => onSavePressed(manager),
            child: Text(
              'СОХРАНИТЬ',
              style: appBarButtonStyle,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TaskTextField(),
                  SizedBox(height: 28),
                  ImportanceWidget(),
                  SeparatorWidget(),
                  SizedBox(height: 20),
                  DatePickerWidget(),
                  SizedBox(height: 40),
                ],
              ),
            ),
            const SeparatorWidget(),
            DeleteButtonWidget(onDelete: onDelete),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ya_todo_list/settings/device_id.dart';
import '../model/task_item.dart';
import '../model/task_item_manager.dart';
import '../provider/task_item_provider.dart';
import '../theme/app_elements_text_styles.dart';
import 'task_screen_components/date_picker_widget.dart';
import 'task_screen_components/delete_button_widget.dart';
import 'task_screen_components/importance_selection_widget.dart';
import 'task_screen_components/separator_widget.dart';
import 'task_screen_components/task_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  void onSavePressed(TaskItemManager? manager, BuildContext context) async {
    if (manager is TaskItemManager) {
      final deviceId = await DeviceId.getDeviceId(context);
      final task = manager.createTask(deviceId);
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
    final buttonLabel = AppLocalizations.of(context)?.save_button ?? '';
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 720 ? screenWidth * 0.75 : screenWidth;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed:
                isTextFieldEmpty ? null : () => onSavePressed(manager, context),
            child: Text(
              buttonLabel,
              style: appBarButtonStyle,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SeparatorWidget(),
                ),
                DeleteButtonWidget(onDelete: onDelete),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

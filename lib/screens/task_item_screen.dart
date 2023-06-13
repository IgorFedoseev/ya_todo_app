import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/task_item.dart';
import '../model/task_item_manager.dart';
import '../provider/task_item_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_elements_color.dart';
import '../theme/app_text_styles.dart';

class TaskItemScreenProviderWidget extends StatefulWidget {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  final TaskItem? existingTask;
  const TaskItemScreenProviderWidget({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.existingTask,
  });

  @override
  State<TaskItemScreenProviderWidget> createState() =>
      _TaskItemScreenProviderWidgetState();
}

class _TaskItemScreenProviderWidgetState
    extends State<TaskItemScreenProviderWidget> {
  late final TaskItemManager _model;

  @override
  void initState() {
    super.initState();
    final task = widget.existingTask;
    final isTaskExist = task != null;
    _model = TaskItemManager(
      existingTask: task,
      isUpdateing: isTaskExist,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TaskItemProvider(
      model: _model,
      child: TaskItemScreenWidget(
        onCreate: widget.onCreate,
        onUpdate: widget.onUpdate,
      ),
    );
  }
}

class TaskItemScreenWidget extends StatelessWidget {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  const TaskItemScreenWidget({
    super.key,
    required this.onCreate,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final taskTitle = TaskItemProvider.of(context)?.taskTitle;
    final isTextFieldEmpty = taskTitle?.trim().isEmpty ?? true;
    final appBarButtonStyle = AppTextStyles.textButtonStyle(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: isTextFieldEmpty
                ? null
                : () {
                    final model = TaskItemProvider.getModel(context);
                    if (model is TaskItemManager) {
                      final task = model.createTask();
                      final isTaskUpdated = model.isUpdateing;
                      if (isTaskUpdated) {
                        onUpdate(task);
                      } else {
                        onCreate(task);
                      }
                    }
                  },
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
                  _SeparatorWidget(),
                  SizedBox(height: 20),
                  DatePickerWidget(),
                  SizedBox(height: 40),
                ],
              ),
            ),
            const _SeparatorWidget(),
            const DeleteButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key});

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final manager = TaskItemProvider.getModel(context);
    final task = manager?.existingTask;
    print(task?.title);
    if (task != null) {
      _controller.text = task.title;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFieldColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.backSecondary
        : LightThemeColors.backSecondary;
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: _controller,
        onChanged: (text) =>
            TaskItemProvider.getModel(context)?.taskTitle = text,
        autofocus: true,
        style: AppTextStyles.regylarBodyText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          fillColor: textFieldColor,
          filled: true,
          hintText: 'Что надо сделать…',
          hintStyle: AppTextStyles.regylarBodyText,
        ),
        minLines: 3,
        maxLines: 100,
      ),
    );
  }
}

class _SeparatorWidget extends StatelessWidget {
  const _SeparatorWidget();

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.supportSeparator
        : LightThemeColors.supportSeparator;
    return ColoredBox(
      color: dividerColor,
      child: const SizedBox(height: 1.0, width: double.infinity),
    );
  }
}

class ImportanceWidget extends StatelessWidget {
  const ImportanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final isHighImportance = manager?.taskImportance == Importance.high;
    final importanceText =
        TaskItemProvider.of(context)?.taskImportanceText ?? 'Нет';
    final smallTextStyle = isHighImportance
        ? AppTextStyles.highValueStyle(context)
        : AppTextStyles.lowValueStyle(context);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              insetPadding:
                  const EdgeInsets.only(bottom: 180, right: 180, left: 16),
              child: SizedBox(
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
              ),
            );
          }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Важность', style: AppTextStyles.regylarBodyText),
          const SizedBox(height: 4.0),
          Text(importanceText, style: smallTextStyle),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

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

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  bool isSwitched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDateSelected = TaskItemProvider.of(context)?.taskDate != null;
    if (isDateSelected) {
      isSwitched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeSwitchColor = TodoElementsColor.getBlueColor(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Сделать до', style: AppTextStyles.regylarBodyText),
            if (isSwitched) const DatePickerButton(),
          ],
        ),
        Switch(
          activeColor: activeSwitchColor,
          value: isSwitched,
          onChanged: (isOn) {
            if (!isOn) TaskItemProvider.getModel(context)?.taskDate = null;
            setState(() {
              isSwitched = isOn;
            });
          },
        ),
      ],
    );
  }
}

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final currentDate = DateTime.now();
    final taskDate = manager?.taskDate ?? currentDate;
    final appBarButtonStyle = AppTextStyles.textButtonStyle(context);
    return GestureDetector(
      child: Text(
        DateFormat.yMMMMd('ru').format(taskDate),
        style: appBarButtonStyle,
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          locale: const Locale("ru", "RU"),
          initialDate: manager?.taskDate ?? currentDate,
          firstDate: currentDate,
          lastDate: DateTime(currentDate.year + 5),
        );
        if (selectedDate != null) {
          manager?.taskDate = selectedDate;
        }
      },
    );
  }
}

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  void _onPressed(BuildContext context, TaskItemManager? manager) {
    final isTaskExist = manager?.existingTask != null;
    if (isTaskExist) {
      () {};
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final taskTitle = manager?.taskTitle;
    final isTextFieldEmpty = taskTitle?.trim().isEmpty ?? true;
    final deleteButtonColor = TodoElementsColor.getRedColor(context);
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 200),
      child: TextButton(
        onPressed: isTextFieldEmpty ? null : () => _onPressed(context, manager),
        style: TextButton.styleFrom(
          foregroundColor: deleteButtonColor,
        ),
        child: Row(
          children: const [
            Icon(Icons.delete),
            SizedBox(width: 10),
            Text('Удалить'),
          ],
        ),
      ),
    );
  }
}

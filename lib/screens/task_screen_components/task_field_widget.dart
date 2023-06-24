import 'package:flutter/material.dart';

import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final hintText = AppLocalizations.of(context)?.textfield_hint ?? '';
    final textFieldColor = TodoElementsColor.getBackSecondaryColor(context);
    final hintStyle = AppTextStyles.regylarBodyText
        .copyWith(color: TodoElementsColor.getTertiaryColor(context));
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
          hintText: hintText,
          hintStyle: hintStyle,
        ),
        minLines: 3,
        maxLines: 100,
      ),
    );
  }
}

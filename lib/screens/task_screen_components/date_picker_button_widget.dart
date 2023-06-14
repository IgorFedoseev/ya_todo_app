import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_elements_text_styles.dart';

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = TaskItemProvider.of(context);
    final currentDate = DateTime.now();
    final taskDate = manager?.taskDate ?? currentDate;
    final appBarButtonStyle = AppElementsTextStyles.textButtonStyle(context);
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
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: TodoElementsColor.getDatePickerScheme(context),
              ),
              child: child!,
            );
          },
        );
        if (selectedDate != null) {
          manager?.taskDate = selectedDate;
        }
      },
    );
  }
}

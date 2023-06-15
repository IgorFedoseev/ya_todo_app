import 'package:flutter/material.dart';

import '../../model/task_item_manager.dart';
import '../../provider/task_item_provider.dart';
import '../../theme/app_elements_color.dart';
import '../../theme/app_text_styles.dart';
import 'date_picker_button_widget.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  bool isSwitched = false;
  late TaskItemManager? manager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    manager = TaskItemProvider.of(context);
    final isDateSelected = manager?.taskDate != null;
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
            if (!isOn) manager?.taskDate = null;
            setState(() {
              isSwitched = isOn;
            });
          },
        ),
      ],
    );
  }
}
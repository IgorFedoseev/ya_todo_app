import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor = TodoElementsColor.getSeparatorColor(context);
    return ColoredBox(
      color: dividerColor,
      child: const SizedBox(height: 1.0, width: double.infinity),
    );
  }
}

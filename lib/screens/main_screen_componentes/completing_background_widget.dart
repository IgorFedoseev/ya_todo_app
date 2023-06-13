import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';

class CompletingBackgroundWidget extends StatelessWidget {
  const CompletingBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bacgroundColor = TodoElementsColor.getGreenColor(context);
    final iconColor = TodoElementsColor.getWhiteColor(context);
    return Container(
      color: bacgroundColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Icon(
              Icons.check,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}

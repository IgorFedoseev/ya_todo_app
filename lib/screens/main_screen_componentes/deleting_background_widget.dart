import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';

class DeletingBackgroundWidget extends StatelessWidget {
  const DeletingBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bacgroundColor = TodoElementsColor.getRedColor(context);
    final iconColor = TodoElementsColor.getWhiteColor(context);
    return Container(
      color: bacgroundColor,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: iconColor,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../model/task_item.dart';
import '../../theme/app_elements_color.dart';

class CheckBoxIconWidget extends StatelessWidget {
  final TaskItem task;
  const CheckBoxIconWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskCompletedState = task.isDone;
    final isUrgent = task.importance == Importance.high;
    if (taskCompletedState) {
      return Icon(
        Icons.check_box,
        color: TodoElementsColor.getGreenColor(context),
        size: 27.0,
      );
    } else if (isUrgent) {
      return SizedBox(
        width: 18,
        height: 18,
        child: CustomPaint(painter: MyPainter(context)),
      );
    }
    return Icon(
      Icons.square_outlined,
      color: TodoElementsColor.getSeparatorColor(context),
      size: 27.0,
    );
  }
}

class MyPainter extends CustomPainter {
  final BuildContext context;
  MyPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 18,
      height: 18,
    );

    final paintRect = Paint()
      ..color = const Color.fromRGBO(250, 225, 223, 1.0)
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paintRect);

    final paintStrokeRect = Paint()
      ..color = TodoElementsColor.getRedColor(context)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, paintStrokeRect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

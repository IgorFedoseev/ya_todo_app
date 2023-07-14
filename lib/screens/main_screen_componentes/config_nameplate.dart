import 'package:flutter/material.dart';

import '../../theme/app_elements_color.dart';
import '../../theme/app_text_styles.dart';

class ConfigNameplate extends StatelessWidget {
  const ConfigNameplate({super.key});

  @override
  Widget build(BuildContext context) {
    final redColor = TodoElementsColor.getRedColor(context);
    final whiteColor = TodoElementsColor.getWhiteColor(context);
    final textSTyle = AppTextStyles.listTextStyle
        .copyWith(color: whiteColor, fontWeight: FontWeight.w800);
    return Positioned(
      top: 50,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'DEV',
          style: textSTyle,
        ),
      ),
    );
  }
}

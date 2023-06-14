import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

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

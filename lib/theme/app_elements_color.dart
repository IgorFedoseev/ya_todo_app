import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class TodoElementsColor {
  static Color getBlueColor(BuildContext context) {
    final blueColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorBlue
        : LightThemeColors.colorBlue;
    return blueColor;
  }

  static Color getRedColor(BuildContext context) {
    final redColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorRed
        : LightThemeColors.colorRed;
    return redColor;
  }

  static Color getGreenColor(BuildContext context) {
    final greenColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorGreen
        : LightThemeColors.colorGreen;
    return greenColor;
  }

  static Color getWhiteColor(BuildContext context) {
    final whiteColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorWhite
        : LightThemeColors.colorWhite;
    return whiteColor;
  }
}

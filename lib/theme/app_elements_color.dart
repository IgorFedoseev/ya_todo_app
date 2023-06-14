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

  static Color getGreyColor(BuildContext context) {
    final greyColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorGray
        : LightThemeColors.colorGray;
    return greyColor;
  }

  static Color getTertiaryColor(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.labelTertiary
        : LightThemeColors.labelTertiary;
    return color;
  }

  static Color getSeparatorColor(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.supportSeparator
        : LightThemeColors.supportSeparator;
    return color;
  }

  static Color getBackSecondaryColor(BuildContext context) {
    final redColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.backSecondary
        : LightThemeColors.backSecondary;
    return redColor;
  }

  static ColorScheme getDatePickerScheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const darkScheme = ColorScheme.dark(primary: DarkThemeColors.colorBlue);
    const liteScheme = ColorScheme.light(primary: LightThemeColors.colorBlue);
    final colorScheme = isDark ? darkScheme : liteScheme;
    return colorScheme;
  }

  static Color getCustomImpotanceColor(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.customHighImportance
        : LightThemeColors.customHighImportance;
    return color;
  }
}

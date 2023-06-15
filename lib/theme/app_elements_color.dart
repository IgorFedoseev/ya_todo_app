import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class TodoElementsColor {
  static Color getBlueColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.colorBlue : LightThemeColors.colorBlue;
    return color;
  }

  static Color getRedColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? DarkThemeColors.colorRed : LightThemeColors.colorRed;
    return color;
  }

  static Color getGreenColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.colorGreen : LightThemeColors.colorGreen;
    return color;
  }

  static Color getWhiteColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.colorWhite : LightThemeColors.colorWhite;
    return color;
  }

  static Color getGreyColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.colorGray : LightThemeColors.colorGray;
    return color;
  }

  static Color getTertiaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.labelTertiary : LightThemeColors.labelTertiary;
    return color;
  }

  static Color getSeparatorColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? DarkThemeColors.supportSeparator
        : LightThemeColors.supportSeparator;
    return color;
  }

  static Color getBackPrimaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.backPrimary : LightThemeColors.backPrimary;
    return color;
  }

  static Color getBackSecondaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.backSecondary : LightThemeColors.backSecondary;
    return color;
  }

  static Color getLabelPrimaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? DarkThemeColors.labelPrimary : LightThemeColors.labelPrimary;
    return color;
  }

  static ColorScheme getDatePickerScheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const darkScheme = ColorScheme.dark(primary: DarkThemeColors.colorBlue);
    const liteScheme = ColorScheme.light(primary: LightThemeColors.colorBlue);
    final colorScheme = isDark ? darkScheme : liteScheme;
    return colorScheme;
  }

  static Color getCustomImpotanceColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? DarkThemeColors.customHighImportance
        : LightThemeColors.customHighImportance;
    return color;
  }
}

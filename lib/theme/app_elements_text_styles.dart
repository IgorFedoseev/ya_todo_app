import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppElementsTextStyles {
  static TextStyle textButtonStyle(BuildContext context) {
    final appBarButtonColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorBlue
        : LightThemeColors.colorBlue;
    final appBarButtonStyle =
        AppTextStyles.appbarAcionTextStyle.copyWith(color: appBarButtonColor);
    return appBarButtonStyle;
  }

  static TextStyle newTaskButtonStyle(BuildContext context) {
    final textButtonColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.labelTertiary
        : LightThemeColors.labelTertiary;
    final appBarButtonStyle =
        AppTextStyles.regylarBodyText.copyWith(color: textButtonColor);
    return appBarButtonStyle;
  }

  static TextStyle lowValueStyle(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.labelTertiary
        : LightThemeColors.labelTertiary;
    final style = AppTextStyles.smallBodyText.copyWith(color: textColor);
    return style;
  }

  static TextStyle highValueStyle(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? DarkThemeColors.colorRed
        : LightThemeColors.colorRed;
    final style = AppTextStyles.smallBodyText.copyWith(color: textColor);
    return style;
  }
}

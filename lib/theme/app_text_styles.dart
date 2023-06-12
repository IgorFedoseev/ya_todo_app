import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle listTextStyle = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle appbarAcionTextStyle = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regylarBodyText = GoogleFonts.roboto(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallBodyText = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

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
}

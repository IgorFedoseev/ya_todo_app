import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTheme {
  static ThemeData get lightTheme {
    // todo: add theme data main colors
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        // todo: add font sizes, weights, colors,
        headline1: GoogleFonts.roboto().copyWith(),
        headline2: GoogleFonts.roboto().copyWith(),
        subtitle1: GoogleFonts.roboto().copyWith(),
        subtitle2: GoogleFonts.roboto().copyWith(),
        bodyText1: GoogleFonts.roboto().copyWith(),
        bodyText2: GoogleFonts.roboto().copyWith(),
      ),
    );
  }
}

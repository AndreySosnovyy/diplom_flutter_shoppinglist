import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        headline1: GoogleFonts.roboto().copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        headline2: GoogleFonts.roboto().copyWith(),
        subtitle1: GoogleFonts.roboto().copyWith(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: AppColors.greyHint,
        ),
        subtitle2: GoogleFonts.roboto().copyWith(),
        bodyText1: GoogleFonts.roboto().copyWith(),
        bodyText2: GoogleFonts.roboto().copyWith(),
      ),
    );
  }
}

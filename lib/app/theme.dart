import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// todo: change text theme for adaptive dialogs
mixin AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        headline1: GoogleFonts.roboto().copyWith(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        headline2: GoogleFonts.roboto().copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        subtitle1: GoogleFonts.roboto().copyWith(
          fontSize: 26,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        subtitle2: GoogleFonts.roboto().copyWith(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        bodyText1: GoogleFonts.roboto().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        bodyText2: GoogleFonts.roboto().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
      ),
    );
  }
}

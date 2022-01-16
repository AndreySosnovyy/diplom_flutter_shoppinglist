import 'package:flutter/material.dart';

class AppColors {
  // core colors
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFEFEFEF);
  static const greyHint = Color(0xFFAAAAAA);
  static const black = Color(0xFF000000);
  static const blue = Color(0xFF3636FF);

  // palettes
  static const palette1 = Palette1();
  static const palette2 = Palette2();
}

class Palette1 {
  const Palette1();

  final flickrPink = const Color(0xFFF72585);
  final byzantine = const Color(0xFFB5179E);
  final purple1 = const Color(0xFF7209B7);
  final purple2 = const Color(0xFF560BAD);
  final trypanBlue1 = const Color(0xFF480CA8);
  final trypanBlue2 = const Color(0xFF3A0CA3);
  final persianBlue = const Color(0xFF3F37C9);
  final ultramarineBlue = const Color(0xFF4361EE);
  final dodgerBlue = const Color(0xFF4895EF);
  final vividSkyBlue = const Color(0xFF4CC9F0);
}

class Palette2 {
  const Palette2();

  final violetBlueCrayola1 = const Color(0xFF757BC8);
  final violetBlueCrayola2 = const Color(0xFF8187DC);
  final cornflowerBlue = const Color(0xFF8E94F2);
  final maximumBluePurple1 = const Color(0xFF9FA0FF);
  final maximumBluePurple2 = const Color(0xFFADA7FF);
  final maximumBluePurple3 = const Color(0xFFBBADFF);
  final mauve1 = const Color(0xFFCBB2FE);
  final mauve2 = const Color(0xFFDAB6FC);
  final mauve3 = const Color(0xFFDDBDFC);
  final mauve4 = const Color(0xFFE0C3FC);
}

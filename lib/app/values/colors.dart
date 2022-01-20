import 'package:flutter/cupertino.dart';

class AppColors {
  // core colors
  static const white = CupertinoColors.white;
  static const black = CupertinoColors.black;
  static const grey1 = CupertinoColors.systemGrey;
  static const grey2 = CupertinoColors.systemGrey4;
  static const grey3 = CupertinoColors.systemGrey6;

  static const red = CupertinoColors.systemRed;
  static const green = CupertinoColors.activeGreen;
  static const blue = CupertinoColors.activeBlue;
  static const yellow = CupertinoColors.systemYellow;
  static const indigo = CupertinoColors.systemIndigo;
  static const orange = CupertinoColors.systemOrange;
  static const pink = CupertinoColors.systemPink;
  static const teal = CupertinoColors.systemTeal;

  static final mainGradientColors = [
    AppColors.palette.flickrPink,
    AppColors.palette.trypanBlue1,
    AppColors.palette.vividSkyBlue
  ];

  // palettes
  static const palette = Palette();
}

class Palette {
  const Palette();

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

class ShoppingListTileColor {
  static const red = AppColors.red;
  static const green = AppColors.green;
  static const blue = AppColors.blue;
  static const yellow = AppColors.yellow;
  static const indigo = AppColors.indigo;
  static const pink = AppColors.pink;
  static const teal = AppColors.teal;
  static const black = AppColors.black;
}

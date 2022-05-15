import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDataSource {
  late final SharedPreferences prefs;

  Future init() async => prefs = await SharedPreferences.getInstance();

  final _showProductImageKey = 'show product images';
  final _defaultColorKey = 'default color';

  Future setShowProductImages(bool value) async =>
      await prefs.setBool(_showProductImageKey, value);

  bool get showProductImages => prefs.getBool(_showProductImageKey) ?? true;

  Future setDefaultColor(Color color) async =>
      await prefs.setInt(_defaultColorKey, color.value);

  Color get defaultColor =>
      Color(prefs.getInt(_defaultColorKey) ?? AppColors.blue.value);
}

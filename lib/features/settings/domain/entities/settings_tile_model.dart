import 'package:flutter/cupertino.dart';

class SettingsTileModel {
  final String title;
  final Icon icon;
  final Color iconColor;
  final VoidCallback? callback;
  final Widget? trailingSwitch;

  SettingsTileModel({
    required this.title,
    required this.icon,
    required this.iconColor,
    this.callback,
    this.trailingSwitch,
  });
}

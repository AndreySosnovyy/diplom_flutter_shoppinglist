import 'dart:typed_data';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/data/settings_local_data_source.dart';
import 'package:diplom/features/settings/data/settings_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsService {
  SettingsService({
    required this.usersRemoteDataSource,
    required this.localDataSource,
  });

  final UsersRemoteDataSource usersRemoteDataSource;
  final SettingsLocalDataSource localDataSource;

  late final PackageInfo _packageInfo;
  late final String displayVersion;
  late bool showProductImages;
  late Color defaultColor;
  late String? avatarUrl;
  late String userName;
  late String? userHandler;
  late bool isHiddenAccount;

  final List<Color> availableColors = [
    AppColors.black,
    AppColors.grey2,
    AppColors.red,
    AppColors.green,
    AppColors.blue,
    AppColors.indigo,
    AppColors.orange,
    AppColors.pink,
    AppColors.teal,
    AppColors.jellyBean,
  ];

  String colorName(Color color) {
    if (color == AppColors.black) return 'Черный';
    if (color == AppColors.grey2) return 'Серый';
    if (color == AppColors.red) return 'Красный';
    if (color == AppColors.green) return 'Зеленый';
    if (color == AppColors.blue) return 'Синий';
    if (color == AppColors.indigo) return 'Индиго';
    if (color == AppColors.orange) return 'Оранжевый';
    if (color == AppColors.pink) return 'Розовый';
    if (color == AppColors.teal) return 'Голубой';
    if (color == AppColors.jellyBean) return 'Насыщенный зеленый';
    throw Exception('Invalid color provided');
  }

  Future init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    displayVersion = _packageInfo.version;
    
    await localDataSource.init();
    await usersRemoteDataSource.init();

    // local value
    showProductImages = localDataSource.showProductImages;
    defaultColor = localDataSource.defaultColor;

    // remote values
    avatarUrl = null;
    userName = 'Имя пользователя';
    userHandler = '@user_handler';
    isHiddenAccount = true;
  }

  Future setDefaultColor(Color color) async {
    await localDataSource.setDefaultColor(color);
    defaultColor = color;
  }

  Future setShowProductImages(bool value) async {
    await localDataSource.setShowProductImages(value);
    showProductImages = value;
  }

  Future setAvatar(Uint8List bytes) async {
    await usersRemoteDataSource.setCurrentAppUserAvatar(bytes);
    avatarUrl = await usersRemoteDataSource.avatarUrl;
  }

  Future setUserName(String newName) async {
    await usersRemoteDataSource.setCurrentAppUserName(newName);
    userName = newName;
  }

  Future setHandler(String newHandler) async {
    await usersRemoteDataSource.setCurrentAppUserHandler(newHandler);
    userHandler = newHandler;
  }

  Future setIsHiddenAccount(bool value) async {
    await usersRemoteDataSource.setCurrentAppUserIsHiddenAccount(value);
    isHiddenAccount = value;
  }
}

import 'dart:typed_data';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/data/settings_local_data_source.dart';
import 'package:diplom/features/settings/data/settings_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsService {
  SettingsService({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final SettingsRemoteDataSource remoteDataSource;
  final SettingsLocalDataSource localDataSource;

  late final PackageInfo _packageInfo;
  late final String displayVersion;
  late bool showProductImages;
  late Color defaultColor;
  late String avatarUrl;
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
    await remoteDataSource.init();

    showProductImages = localDataSource.showProductImages;
    defaultColor = localDataSource.defaultColor;
  }

  Future setDefaultColor(Color color) async {
    await localDataSource.setDefaultColor(color);
    defaultColor = color;
  }

  Future setShowProductImages(bool value) async {
    await localDataSource.setShowProductImages(value);
    showProductImages = value;
  }

  // todo: implement method
  Future setAvatar(Uint8List bytes) async => throw UnimplementedError();

  // todo: implement method
  Future setUserName(String newName) async => throw UnimplementedError();

  // todo: implement method
  Future setHandler(String newHandler) async => throw UnimplementedError();

  // todo: implement method
  Future setIsHiddenAccount(bool value) async => throw UnimplementedError();
}

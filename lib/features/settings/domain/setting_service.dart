import 'dart:typed_data';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/entities/app_user.dart';
import 'package:diplom/features/settings/data/settings_local_data_source.dart';
import 'package:diplom/features/settings/data/settings_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsService {
  SettingsService({
    required this.auth,
    required this.usersDataSource,
    required this.localDataSource,
  });

  final FirebaseAuth auth;
  final UsersDataSource usersDataSource;
  final SettingsDataSource localDataSource;

  late final PackageInfo _packageInfo;
  late final String displayVersion;
  late bool showProductImages;
  late Color defaultColor;
  String? avatarUrl;
  String? userName;
  String? userHandler;
  bool? isHiddenAccount;

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

    // local stored data (application settings data)
    await localDataSource.init();
    showProductImages = localDataSource.showProductImages;
    defaultColor = localDataSource.defaultColor;

    // remote stored data (user account data)
    if (auth.currentUser != null) await fetchAppUser();
  }

  Future fetchAppUser() async {
    final currentAppUser =
        await usersDataSource.getAppUser(userId: auth.currentUser!.uid);
    avatarUrl = currentAppUser.avatarUrl;
    userName = currentAppUser.name;
    userHandler = currentAppUser.handler;
    isHiddenAccount = currentAppUser.isHidden;
  }

  Future setDefaultColor(Color color) async {
    await localDataSource.setDefaultColor(color);
    defaultColor = color;
  }

  Future setShowProductImages(bool value) async {
    await localDataSource.setShowProductImages(value);
    showProductImages = value;
  }

  Future setAvatar(Uint8List? bytes) async {
    await usersDataSource.setUserAvatar(
      bytes: bytes,
      userId: auth.currentUser!.uid,
    );
    avatarUrl = await usersDataSource.getUserAvatarUrl(
      userId: auth.currentUser!.uid,
    );
  }

  Future setUserName(String newName) async {
    await usersDataSource.setUserName(
      newName: newName,
      userId: auth.currentUser!.uid,
    );
    userName = newName;
  }

  Future setHandler(String newHandler) async {
    await usersDataSource.setCurrentAppUserHandler(
      handler: newHandler,
      userId: auth.currentUser!.uid,
    );
    userHandler = newHandler;
  }

  Future setIsHiddenAccount(bool value) async {
    await usersDataSource.setCurrentAppUserIsHiddenAccount(
      value: value,
      userId: auth.currentUser!.uid,
    );
    isHiddenAccount = value;
  }

  Future<bool> checkIfHandlerUnique(String handler) async =>
      (await usersDataSource.fetchAppUserByHandler(handler)) == null
          ? true
          : false;

  Future<AppUser?> fetchAppUserByHandler(String handler) async =>
      await usersDataSource.fetchAppUserByHandler(handler);
}

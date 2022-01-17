import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/entities/settings_tile_model.dart';
import 'package:flutter/cupertino.dart';

class SettingsBlocksContent {
  static List<SettingsTileModel> getAccountBlockContent({
    required VoidCallback changeNameCallback,
    required VoidCallback changeHandlerCallback,
    required CupertinoSwitch hideAccountSwitch,
  }) {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.pen, color: AppColors.white),
        iconColor: AppColors.green,
        title: 'Сменить имя и фамилию',
        callback: changeNameCallback,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.pen, color: AppColors.white),
        iconColor: AppColors.green,
        title: 'Сменить имя пользователя',
        callback: changeHandlerCallback,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.at, color: AppColors.white),
        iconColor: AppColors.red,
        title: 'Скрыть аккаунт',
        trailingSwitch: hideAccountSwitch,
      ),
    ];
  }

  static List<SettingsTileModel> getApplicationBlockContent({
    required CupertinoSwitch notificationSwitch,
    required CupertinoSwitch soundsSwitch,
    required CupertinoSwitch vibrationSwitch,
  }) {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.app_badge, color: AppColors.white),
        iconColor: AppColors.pink,
        title: 'Уведомления',
        trailingSwitch: notificationSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.music_note_2, color: AppColors.white),
        iconColor: AppColors.blue,
        title: 'Звуки',
        trailingSwitch: soundsSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.at, color: AppColors.white),
        iconColor: AppColors.indigo,
        title: 'Вибрация',
        trailingSwitch: vibrationSwitch,
      ),
    ];
  }
}

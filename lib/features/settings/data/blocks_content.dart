import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/entities/settings_tile_model.dart';
import 'package:flutter/cupertino.dart';

class SettingsBlocksContent {
  static List<SettingsTileModel> getAccountBlockContent({
    required VoidCallback changeNameCallback,
    required VoidCallback changeHandlerCallback,
    required CupertinoSwitch hideAccountSwitch,
    required VoidCallback logOutCallback,
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
        iconColor: AppColors.yellow,
        title: 'Сменить имя пользователя',
        callback: changeHandlerCallback,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.at, color: AppColors.white),
        iconColor: AppColors.teal,
        title: 'Скрыть аккаунт',
        trailingSwitch: hideAccountSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.arrow_left_square, color: AppColors.white),
        iconColor: AppColors.red,
        title: 'Выйти',
        callback: logOutCallback,
      ),
    ];
  }

  static List<SettingsTileModel> getAuthBlockContent({
    required VoidCallback signInCallback,
  }) {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.arrow_right, color: AppColors.white),
        iconColor: AppColors.green,
        title: 'Войти',
        callback: signInCallback,
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
        icon: const Icon(CupertinoIcons.slowmo, color: AppColors.white),
        iconColor: AppColors.indigo,
        title: 'Вибрация',
        trailingSwitch: vibrationSwitch,
      ),
    ];
  }

  static List<SettingsTileModel> getShoppingBlockContent({
    required CupertinoSwitch productsPicturesSwitch,
  }) {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.cart, color: AppColors.white),
        iconColor: AppColors.blue,
        title: 'Изображения товаров',
        trailingSwitch: productsPicturesSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.delete, color: AppColors.white),
        iconColor: AppColors.red,
        title: 'Автоматическое удаление',
      ),
    ];
  }

  static List<SettingsTileModel> getOtherBlockContent() {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.creditcard, color: AppColors.white),
        iconColor: AppColors.green,
        title: 'Снять ограничения',
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.ellipsis, color: AppColors.white),
        iconColor: AppColors.black,
        title: 'Прочее',
      ),
    ];
  }
}
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/entities/settings_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsBlocksContent {
  static List<SettingsTileModel> getAccountBlockContent({
    required bool hideEditNameTile,
    VoidCallback? changeNameCallback,
    VoidCallback? changeHandlerCallback,
    required CupertinoSwitch hideAccountSwitch,
    required VoidCallback signOutCallback,
  }) {
    return <SettingsTileModel>[
      if (!hideEditNameTile)
        SettingsTileModel(
          icon: const Icon(CupertinoIcons.pen, color: AppColors.white),
          iconColor: AppColors.green,
          title: 'Сменить имя и фамилию',
          callback: changeNameCallback,
        ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.pen, color: AppColors.white),
        iconColor: AppColors.yellow,
        title: 'Сменить хэндлер пользователя',
        callback: changeHandlerCallback,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.at, color: AppColors.white),
        iconColor: AppColors.teal,
        title: 'Скрыть аккаунт',
        trailingSwitch: hideAccountSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.arrow_left_square,
            color: AppColors.white),
        iconColor: AppColors.red,
        title: 'Выйти',
        callback: signOutCallback,
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
        icon: const FaIcon(FontAwesomeIcons.bell, color: AppColors.white),
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
    required Color defaultColorIconColor,
    required VoidCallback setDefaultColorCallback,
  }) {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const Icon(CupertinoIcons.cart, color: AppColors.white),
        iconColor: AppColors.blue,
        title: 'Изображения товаров',
        trailingSwitch: productsPicturesSwitch,
      ),
      SettingsTileModel(
        icon: const Icon(FontAwesomeIcons.palette, color: AppColors.white),
        iconColor: defaultColorIconColor,
        title: 'Цвет по умолчанию',
        callback: setDefaultColorCallback,
      ),
      // SettingsTileModel(
      //   icon: const Icon(CupertinoIcons.delete, color: AppColors.white),
      //   iconColor: AppColors.red,
      //   title: 'Автоматическое удаление',
      // ),
    ];
  }

  static List<SettingsTileModel> getOtherBlockContent() {
    return <SettingsTileModel>[
      SettingsTileModel(
        icon: const FaIcon(FontAwesomeIcons.dollarSign, color: AppColors.white),
        iconColor: AppColors.green,
        title: 'Снять ограничения',
      ),
      SettingsTileModel(
        icon: const FaIcon(FontAwesomeIcons.ellipsis, color: AppColors.white),
        iconColor: AppColors.black,
        title: 'Прочее',
      ),
    ];
  }
}

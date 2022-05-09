import 'package:auto_size_text/auto_size_text.dart';
import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/data/blocks_content.dart';
import 'package:diplom/features/settings/domain/setting_service.dart';
import 'package:diplom/features/settings/presentation/screens/settings/settings_viewmodel.dart';
import 'package:diplom/features/settings/presentation/widgets/avatar.dart';
import 'package:diplom/features/settings/presentation/widgets/settings_block.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../auth/domain/auth_service.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(
        router: sl.get<AppRouter>(),
        auth: sl.get<AuthService>(),
        settings: sl.get<SettingsService>(),
        imagePicker: ImagePicker(),
        database: FirebaseDatabase.instance,
      ),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.grey3,
        appBar: CommonAppbar(
          title: 'Настройки',
          leading: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(
                CupertinoIcons.back,
                size: 26,
                color: AppColors.blue,
              ),
              const SizedBox(width: 2),
              Text(
                'Назад',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColors.blue),
              ),
            ],
          ),
          leadingCallback: viewModel.backButtonCallback,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 14),
                Avatar(
                  imageUrl: viewModel.avatarUrl,
                  canBeEdited: viewModel.authProvider == AuthProvider.phone,
                  onTap: () => viewModel.setAvatar(context),
                ),
                const SizedBox(height: 14),
                AutoSizeText(
                  viewModel.displayName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
                ),
                if (viewModel.isSignedIn && viewModel.displayHandler != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AutoSizeText(
                      viewModel.displayHandler!,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.grey1),
                    ),
                  ),
                const SizedBox(height: 20),
                if (viewModel.isSignedIn)
                  SettingsBlock(
                    title: 'Мой аккаунт',
                    settingsContent:
                        SettingsBlocksContent.getAccountBlockContent(
                      hideEditNameTile:
                          viewModel.authProvider != AuthProvider.phone,
                      changeNameCallback: () => viewModel.setName(context),
                      changeHandlerCallback: () =>
                          viewModel.setHandler(context),
                      hideAccountSwitch: CupertinoSwitch(
                        value: viewModel.settings.isHidden,
                        onChanged: viewModel.setIsHiddenAccount,
                      ),
                      signOutCallback: viewModel.signOut,
                    ),
                    description:
                        'Если Ваш аккаунт скрыт другие пользователи не смогут добавить Вас соавтором или читателем в свой список покупок',
                  )
                else
                  SettingsBlock(
                    title: 'Авторизация',
                    settingsContent: SettingsBlocksContent.getAuthBlockContent(
                      signInCallback: viewModel.openAuthScreen,
                    ),
                    description:
                        'Авторизированный пользователь может добавлять или быть добавленным соавтором в списки покупок других пользователей, а также пользоваться своими списками на других устройствах',
                  ),
                SettingsBlock(
                  title: 'Списки покупок',
                  settingsContent:
                      SettingsBlocksContent.getShoppingBlockContent(
                    productsPicturesSwitch: CupertinoSwitch(
                      value: viewModel.settings.showProductImages,
                      onChanged: viewModel.setShowProductImages,
                    ),
                    defaultColorIconColor:
                        sl.get<SettingsService>().defaultColor,
                    setDefaultColorCallback: () =>
                        viewModel.pickDefaultColor(context),
                  ),
                  description:
                      'Автоматическое удаление нужно только для Вашего удобства, чтобы не копить слишком много старых списков',
                ),
                const SizedBox(height: 60),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: Center(
                    child: Text(
                      'Версия ${viewModel.displayVersion}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColors.grey1,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

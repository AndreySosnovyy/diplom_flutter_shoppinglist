import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/settings/data/blocks_content.dart';
import 'package:diplom/features/settings/presentation/screens/settings/settings_viewmodel.dart';
import 'package:diplom/features/settings/presentation/widgets/avatar.dart';
import 'package:diplom/features/settings/presentation/widgets/settings_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.grey3,
        appBar: CommonAppbar(
          subtitle: 'Настройки',
          leading: const Icon(
            CupertinoIcons.back,
            size: 26,
            color: AppColors.blue,
          ),
          leadingCallback: viewModel.backButtonCallback,
        ),
        body: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 14),
                    Avatar(
                      imageUrl: viewModel.currentUser?.photoURL,
                      canBeEdited: viewModel.authProvider == AuthProvider.phone,
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),
                    Hero(
                      tag: 'name',
                      child: Text(
                        ' Андрей Сосновый ',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'AndreySosnovyy',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.grey1),
                    ),
                    const SizedBox(height: 20),
                    if (viewModel.isSignedIn)
                      SettingsBlock(
                        title: 'Мой аккаунт',
                        settingsContent:
                            SettingsBlocksContent.getAccountBlockContent(
                          changeNameCallback: () {},
                          changeHandlerCallback: () {},
                          hideAccountSwitch: CupertinoSwitch(
                            value: false,
                            onChanged: (bool newValue) {},
                          ),
                          signOutCallback: viewModel.signOut,
                        ),
                        description:
                            'Если Ваш аккаунт скрыт другие пользователи не смогут добавить Вас соавтором или читателем в свой список покупок',
                      )
                    else
                      SettingsBlock(
                        title: 'Авторизация',
                        settingsContent:
                            SettingsBlocksContent.getAuthBlockContent(
                          signInCallback: viewModel.openAuthScreen,
                        ),
                        description:
                            'Авторизированный пользователь может добавлять или быть добавленным соавтором в списки покупок других пользователей, а также пользоваться своими списками на других устройствах',
                      ),
                    SettingsBlock(
                      title: 'Приложение',
                      settingsContent:
                          SettingsBlocksContent.getApplicationBlockContent(
                        notificationSwitch: CupertinoSwitch(
                          value: true,
                          onChanged: (bool newValue) {},
                        ),
                        soundsSwitch: CupertinoSwitch(
                          value: true,
                          onChanged: (bool newValue) {},
                        ),
                        vibrationSwitch: CupertinoSwitch(
                          value: true,
                          onChanged: (bool newValue) {},
                        ),
                      ),
                    ),
                    SettingsBlock(
                      title: 'Списки покупок',
                      settingsContent:
                          SettingsBlocksContent.getShoppingBlockContent(
                        productsPicturesSwitch: CupertinoSwitch(
                          value: true,
                          onChanged: (bool newValue) {},
                        ),
                      ),
                      description:
                          'Автоматическое удаление нужно только для Вашего удобства, чтобы не копить слишком много старых списков',
                    ),
                    SettingsBlock(
                        title: 'Дополнительно',
                        settingsContent:
                            SettingsBlocksContent.getOtherBlockContent(),
                        description: ''),
                    const SizedBox(height: 60),
                    GestureDetector(
                      // todo: implement version dialog
                      onTap: () {},
                      child: SizedBox(
                        height: 40,
                        width: 120,
                        child: Center(
                          child: Text(
                            'Версия 1.0.0',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: AppColors.grey1,
                                      decoration: TextDecoration.underline,
                                    ),
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
        ),
      ),
    );
  }
}

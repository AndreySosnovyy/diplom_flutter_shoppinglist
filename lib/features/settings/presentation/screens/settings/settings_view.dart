import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/common/presentation/widgets/gradient_icon.dart';
import 'package:diplom/features/settings/data/blocks_content.dart';
import 'package:diplom/features/settings/presentation/screens/settings/settings_viewmodel.dart';
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
          leading: GradientIcon(
            icon: const Icon(CupertinoIcons.back, size: 26),
            colors: AppColors.mainGradientColors,
          ),
          leadingCallback: viewModel.backButtonCallback,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 14),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://aeealberta.org/wp-content/uploads/2018/10/profile.png',
                  ),
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
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                SettingsBlock(
                  title: 'Мой аккаунт',
                  settingsContent: SettingsBlocksContent.getAccountBlockContent(
                    changeNameCallback: () {},
                    changeHandlerCallback: () {},
                    hideAccountSwitch: CupertinoSwitch(
                      value: false,
                      onChanged: (bool newValue) {},
                    ),
                  ),
                  description:
                      'Если Ваш аккаунт скрыт, другие пользователи не смогут добавить Вас в свой список покупок',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

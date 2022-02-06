import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/common/presentation/widgets/common_cupertino_button.dart';
import 'package:diplom/features/common/presentation/widgets/common_cupertino_textfield.dart';
import 'package:diplom/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../sign_in/sign_in_viewmodel.dart';

class SignInWithEmailView extends StatelessWidget {
  const SignInWithEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(context: context),
      builder: (context, viewModel, child) => Scaffold(
        appBar: CommonAppbar(
          backgroundColor: Colors.transparent,
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                Image.asset(
                  Assets.illustrationsMailbox,
                  width: 244,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                Text(
                  'Авторизация',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 4),
                Text(
                  'Введите электронную почту, чтобы получить на нее ссылку для подтверждения входа',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.grey1),
                ),
                const SizedBox(height: 66),
                CommonCupertinoTextField(
                  hint: 'Электронная почта',
                  controller: viewModel.emailController,
                ),
                const SizedBox(height: 22),
                CommonCupertinoButton(
                  onTap: viewModel.signInWithEmail,
                  text: 'Получить письмо',
                  height: 54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

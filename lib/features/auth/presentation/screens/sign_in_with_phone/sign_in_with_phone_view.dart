import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/presentation/widgets/common_cupertino_button.dart';
import 'package:diplom/app/presentation/widgets/common_cupertino_textfield.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/values/assets.dart';
import '../sign_in/sign_in_viewmodel.dart';

class SignInWithPhoneView extends StatelessWidget {
  const SignInWithPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(context: context),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (viewModel.phoneImageVisible)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Image.asset(
                        Assets.illustrationsPhone,
                        width: 244,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  Text(
                    'Авторизация',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Введите номер телефона, чтобы получить смс к кодом для подтверждения входа',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.grey1),
                  ),
                  const SizedBox(height: 22),
                  CommonCupertinoTextField(
                    hint: 'Номер телефона',
                    inputType: TextInputType.phone,
                    controller: viewModel.phoneController,
                  ),
                  const SizedBox(height: 22),
                  CommonCupertinoButton(
                    onTap: viewModel.signInWithPhone,
                    text: 'Получить код',
                    height: 66,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

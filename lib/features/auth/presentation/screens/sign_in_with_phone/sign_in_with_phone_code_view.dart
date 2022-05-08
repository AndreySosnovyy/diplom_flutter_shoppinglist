import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/presentation/widgets/common_cupertino_button.dart';
import 'package:diplom/app/presentation/widgets/common_cupertino_textfield.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../sign_in/sign_in_viewmodel.dart';

class SignInWithPhoneCodeView extends StatelessWidget {
  const SignInWithPhoneCodeView({Key? key}) : super(key: key);

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
                const SizedBox(width: 6),
                const Icon(
                  CupertinoIcons.back,
                  size: 26,
                  color: AppColors.blue,
                ),
                const SizedBox(width: 2),
                Text(
                  'Отмена',
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
                  Text(
                    'Введите код',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'На Ваш номер была отправлена смс с кодом для входа в приложение',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.grey1),
                  ),
                  const SizedBox(height: 22),
                  CommonCupertinoTextField(
                    hint: 'Код из смс',
                    inputType: TextInputType.number,
                    controller: viewModel.codeController,
                  ),
                  const SizedBox(height: 22),
                  CommonCupertinoButton(
                    onTap: viewModel.popCodeScreen,
                    text: 'Подтвердить',
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

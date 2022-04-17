import 'dart:io';

import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_viewmodel.dart';
import 'package:diplom/features/auth/presentation/widgets/sign_in_with_google_button.dart';
import 'package:diplom/features/auth/presentation/widgets/sign_in_with_phone_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/values/assets.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

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
                const SizedBox(height: 54),
                Image.asset(
                  Assets.illustrationsKeys,
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
                  'используйте одну из своих\nучетных записей',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.grey1),
                ),
                const SizedBox(height: 66),
                Platform.isAndroid
                    ? Column(
                        children: [
                          SignInWithGoogleButton(
                            style: SignInWithGoogleButtonStyle.dark,
                            onPressed: viewModel.signInWithGoogle,
                            text: 'Войти с Google',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SignInWithAppleButton(
                            onPressed: viewModel.signInWithApple,
                            text: 'Войти с Apple',
                            iconAlignment: IconAlignment.left,
                          ),
                          const SizedBox(height: 12),
                          SignInWithGoogleButton(
                            style: SignInWithGoogleButtonStyle.dark,
                            onPressed: viewModel.signInWithGoogle,
                            text: 'Войти с Google',
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1,
                        width: (MediaQuery.of(context).size.width - 152) / 2,
                        color: AppColors.grey2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'или',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColors.grey1),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: (MediaQuery.of(context).size.width - 152) / 2,
                        color: AppColors.grey2,
                      ),
                    ],
                  ),
                ),
                SignInWithPhoneButton(
                  onPressed: viewModel.openSignInWithPhoneScreen,
                  text: 'Войти по телефону',
                  style: SignInWithMailButtonStyle.dark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

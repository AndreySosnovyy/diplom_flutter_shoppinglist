import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_viewmodel.dart';
import 'package:diplom/features/auth/presentation/widgets/sign_in_with_google_button.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInWithGoogleButton(
                  style: SignInWithGoogleButtonStyle.dark,
                  onPressed: viewModel.signInWithGoogle,
                  text: 'Войти с Google',
                ),
                const SizedBox(height: 22),
                SignInWithAppleButton(
                  onPressed: viewModel.signInWithApple,
                  text: 'Войти с Apple',
                  iconAlignment: IconAlignment.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

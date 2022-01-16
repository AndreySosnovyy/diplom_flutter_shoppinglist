import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Sign in view', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}

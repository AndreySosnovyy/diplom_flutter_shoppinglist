import 'package:diplom/features/auth/presentation/screens/sign_up/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Sign up view', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}

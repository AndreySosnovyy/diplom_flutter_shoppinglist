import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:flutter/cupertino.dart';

class SignInViewModel extends ChangeNotifier {
  final _router = sl.get<AppRouter>();

  void backButtonCallback() => _router.pop();

  void signInWithGoogle() {}

  void signInWithApple() {}

  void signInWithMail() {}
}
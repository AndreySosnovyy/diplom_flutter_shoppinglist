import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/data/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SignInViewModel extends ChangeNotifier {
  final _router = sl.get<AppRouter>();
  final _auth = sl.get<AuthService>();
  final logger = Logger();

  void backButtonCallback() => _router.pop();

  Future signInWithGoogle() async {
    final user = await _auth.signInWithGoogle();
    logger.i('Sign in with google: user - ${user?.email}');
  }

  Future signInWithApple() async {}

  Future signInWithEmail({
    required String email,
    required String password,
  }) async {}

  Future signUpWithEmail({
    required String email,
    required String password,
  }) async {}

  Future openMailScreen() async =>
      _router.push(const SignInWithEmailViewRoute());
}

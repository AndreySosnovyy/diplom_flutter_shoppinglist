import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/data/auth_service.dart';
import 'package:diplom/features/common/presentation/dialogs/common_cupertino_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SignInViewModel extends ChangeNotifier {
  late final BuildContext context;

  SignInViewModel({required this.context});

  final _router = sl.get<AppRouter>();
  final _auth = sl.get<AuthService>();
  final logger = Logger();

  final emailController = TextEditingController();
  final emailErrorText = '';

  void backButtonCallback() => _router.pop();

  Future signInWithGoogle() async {
    final user = await _auth.signInWithGoogle();
    logger.i('Sign in with google: user - ${user?.email}');
  }

  Future signInWithApple() async {}

  Future signInWithEmail() async {
    final email = emailController.text;
    if (_validateEmail(email)) {
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => const CommonCupertinoDialog(
          title: 'Ошибка',
          text: 'Введите корректную электронную почту',
          buttonText: 'ОК',
        ),
      );
    }
  }

  Future openMailScreen() async =>
      _router.push(const SignInWithEmailViewRoute());

  bool _validateEmail(String email) => EmailValidator.validate(email);
}

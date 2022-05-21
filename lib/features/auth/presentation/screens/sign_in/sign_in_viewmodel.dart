import 'dart:async';

import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/dialogs/common_cupertino_dialog.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  late final BuildContext context;
  late final StreamSubscription<bool> _keyboardSubscription;

  final _router = sl.get<AppRouter>();
  final _auth = sl.get<AuthService>();

  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  var phoneImageVisible = true;

  SignInViewModel({required this.context}) {
    _keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      phoneImageVisible = !visible;
      notifyListeners();
    });
  }


  @override
  void dispose() {
    _keyboardSubscription.cancel();
    super.dispose();
  }

  void backButtonCallback() {
    _keyboardSubscription.cancel();
    _router.pop();
  }

  void popCodeScreen() => _router.pop<String>(codeController.text);

  Future signInWithGoogle() async {
    final user = await _auth.signInWithGoogle();
    if (user != null) {
      _router.popUntilRouteWithName('SettingsViewRoute');
    }
  }

  Future signInWithApple() async {}

  Future signInWithPhone() async {
    final phone = phoneController.text;
    if (_validatePhoneNumber(phone)) {
      await _auth
          .signInWithPhone(
        phone: phone,
        onErrorCallback: () => showCupertinoDialog(
          context: context,
          builder: (context) => const CommonCupertinoDialog(
            title: 'Ошибка',
            text: 'Введен неверный код',
            buttonText: 'ОК',
          ),
        ),
      )
          .then((user) {
        if (user != null) _router.popUntilRouteWithName('SettingsViewRoute');
      });
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => const CommonCupertinoDialog(
          title: 'Ошибка',
          text: 'Введите корректный номер телефона',
          buttonText: 'ОК',
        ),
      );
    }
  }

  Future openSignInWithPhoneScreen() async =>
      _router.push(const SignInWithPhoneViewRoute());

  bool _validatePhoneNumber(String phone) => RegExp(
          r'^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$')
      .hasMatch(phone);
}

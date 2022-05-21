import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/setting_service.dart';

class SettingsViewModel extends FutureViewModel {
  SettingsViewModel({
    required this.router,
    required this.auth,
    required this.settings,
    required this.imagePicker,
    required this.database,
  }) {
    auth.userStream.listen((user) async {
      if (user == null) {
        _avatarUrl = null;
        _userHandler = null;
        _avatarUrl = null;
        _isHiddenAccount = null;
      } else {
        if (!await settings.isUserExists(user.uid)) {
          await settings.addAppUser(
            userId: user.uid,
            appUser: AppUser(
              id: user.uid,
              name: authProvider! == AuthProvider.google
                  ? user.displayName!
                  : 'User name',
              avatarUrl: authProvider! == AuthProvider.google
                  ? user.photoURL
                  : null,
              handler: user.uid,
              listIds: [],
              isHidden: true,
              authProvider: authProvider!.name,
            ),
          );
        }
        await setUserData();
      }
      notifyListeners();
    });
  }

  final AppRouter router;
  final AuthService auth;
  final SettingsService settings;
  final ImagePicker imagePicker;
  final FirebaseDatabase database;

  String? _avatarUrl;
  String? _userName;
  String? _userHandler;
  bool? _isHiddenAccount;

  @override
  bool get rethrowException => true;

  @override
  Future futureToRun() async => await setUserData();

  Future setUserData() async {
    if (auth.isSignedIn) {
      await settings.fetchAppUser();
      _avatarUrl = settings.avatarUrl;
      _userName = settings.userName;
      _userHandler = settings.userHandler;
      _isHiddenAccount = settings.isHiddenAccount;
    }
  }

  void backButtonCallback() => router.pop();

  void openAuthScreen() => router.push(const SignInViewRoute());

  Future signOut() async => await auth.signOut();

  bool get isSignedIn => auth.isSignedIn;

  User? get currentUser => auth.currentUser;

  String? get avatarUrl =>
      authProvider == AuthProvider.google ? currentUser?.photoURL : _avatarUrl;

  String? get displayName {
    if (!auth.isSignedIn) return 'Анонимный пользователь';
    return _userName;
  }

  String? get displayHandler {
    if (!auth.isSignedIn) return null;
    return _userHandler;
  }

  bool? get isHiddenAccount {
    if (!auth.isSignedIn) return false;
    return _isHiddenAccount;
  }

  String get displayVersion => settings.displayVersion;

  Future pickDefaultColor(BuildContext context) async {
    final result = await showConfirmationDialog<Color>(
      context: context,
      title: 'Выберите цвет по умолчанию',
      message: 'Этот цвет будет первым предложенным для новых списков покупок',
      contentMaxHeight: MediaQuery.of(context).size.height * 0.5,
      okLabel: 'Ок',
      cancelLabel: 'Отмена',
      actions: [
        for (var i = 0; i < settings.availableColors.length; i++)
          AlertDialogAction(
            key: settings.availableColors[i],
            label: settings.colorName(settings.availableColors[i]),
            isDefaultAction:
                settings.defaultColor == settings.availableColors[i],
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: settings.availableColors[i]),
          )
      ],
    );
    if (result == null) return;
    await settings.setDefaultColor(result);
    notifyListeners();
  }

  Future setAvatar(BuildContext context) async {
    final result = await showModalActionSheet(
      context: context,
      actions: [
        const SheetAction(
          key: _AvatarAction.camera,
          label: 'Сделать фото',
          icon: CupertinoIcons.photo_camera,
          isDefaultAction: true,
        ),
        const SheetAction(
          key: _AvatarAction.gallery,
          label: 'Выбрать из галереи',
          icon: CupertinoIcons.photo,
        ),
        const SheetAction(
          key: _AvatarAction.delete,
          label: 'Удалить фото',
          icon: CupertinoIcons.photo,
          isDestructiveAction: true,
        )
      ],
    );

    if (result == null) return;
    if (result == _AvatarAction.delete) {
      await settings.setAvatar(null);
    } else {
      final XFile? image = await imagePicker.pickImage(
        source: result == _AvatarAction.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 20,
      );
      if (image == null) return;
      await settings.setAvatar(await image.readAsBytes());
    }

    _avatarUrl = settings.avatarUrl;
    notifyListeners();
  }

  Future setName(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Сменить имя пользователя',
      textFields: [
        const DialogTextField(
          hintText: 'Новое имя',
          autocorrect: false,
        )
      ],
    );
    if (result == null || result.isEmpty) return;

    final newName = result[0];
    if (!_validateName(newName)) {
      return Fluttertoast.showToast(
        msg: 'Новое имя пользователя некорректно, попробуйте другое',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    _userName = newName;
    notifyListeners();
    await settings.setUserName(newName);
  }

  Future setHandler(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Сменить хэндлер пользователя',
      textFields: [
        const DialogTextField(
          hintText: 'Новый хэндлер',
          autocorrect: false,
        )
      ],
    );
    if (result == null || result.isEmpty) return;

    var newHandler = result[0];
    if (newHandler.startsWith('@')) newHandler = newHandler.substring(1);
    if (!_validateHandler(newHandler)) {
      return Fluttertoast.showToast(
        msg: 'Новый хэндлер невалидный',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    if (!await settings.checkIfHandlerUnique(newHandler)) {
      return Fluttertoast.showToast(
        msg: 'Данный хэндлер уже занят',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    _userHandler = newHandler;
    notifyListeners();
    await settings.setHandler(newHandler);
  }

  Future setIsHiddenAccount(bool value) async {
    _isHiddenAccount = value;
    notifyListeners();
    await settings.setIsHiddenAccount(value);
  }

  Future setShowProductImages(bool value) async {
    await settings.setShowProductImages(value);
    notifyListeners();
  }

  AuthProvider? get authProvider {
    if (currentUser == null) return null;
    if (auth.currentUser!.isAnonymous) return AuthProvider.anon;
    switch (currentUser!.providerData.first.providerId) {
      case 'google.com':
        return AuthProvider.google;
      case 'apple.com':
        return AuthProvider.apple;
      case 'phone':
        return AuthProvider.phone;
    }
    throw Exception('Unknown authentication provider');
  }

  // RegExp source : https://stackoverflow.com/questions/12018245/regular-expression-to-validate-username#:~:text=%5E(%3F%3D.%7B8%2C20%7D%24)(%3F!%5B_.%5D)(%3F!.*%5B_.%5D%7B2%7D)%5Ba%2DzA%2DZ0%2D9._%5D%2B(%3F%3C!%5B_.%5D)%24
  bool _validateName(String name) =>
      RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_.])$')
          .hasMatch(name);

  bool _validateHandler(String handler) =>
      RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$')
          .hasMatch(handler);
}

enum _AvatarAction { camera, gallery, delete }

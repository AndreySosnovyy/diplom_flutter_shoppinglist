import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
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
    auth.userStream.listen((user) => notifyListeners());
  }

  final AppRouter router;
  final AuthService auth;
  final SettingsService settings;
  final ImagePicker imagePicker;
  final FirebaseDatabase database;

  late String? _avatarUrl;
  late String _userName;
  late String? _userHandler;

  @override
  Future futureToRun() async => await fetchUserData();

  Future fetchUserData() async {
    // todo: fetch data from database
    _avatarUrl = null;
    _userName = 'Имя пользователя';
    _userHandler = '@user_handler';
  }

  void backButtonCallback() => router.pop();

  void openAuthScreen() => router.push(const SignInViewRoute());

  Future signOut() async => await auth.signOut();

  bool get isSignedIn => auth.isSignedIn;

  User? get currentUser => auth.currentUser;

  String? get avatarUrl {
    return authProvider == AuthProvider.phone
        ? currentUser?.photoURL
        : _avatarUrl;
  }

  String get displayName {
    if (!auth.isSignedIn) return 'Анонимный пользователь';
    return _userName;
  }

  String? get displayHandler {
    if (!auth.isSignedIn) return null;
    return _userHandler;
  }

  String get displayVersion => settings.displayVersion;

  Future setAvatar(BuildContext context) async {
    final result = await showModalActionSheet(
      context: context,
      actions: [
        const SheetAction(
          key: ImageSource.camera,
          label: 'Сделать фото',
          icon: CupertinoIcons.photo_camera,
          isDefaultAction: true,
        ),
        const SheetAction(
          key: ImageSource.gallery,
          label: 'Выбрать из галереи',
          icon: CupertinoIcons.photo,
        )
      ],
    );
    if (result == null) return;

    final XFile? image = await imagePicker.pickImage(
      source: result,
      imageQuality: 20,
    );
    if (image == null) return;

    // todo: upload image to storage and set imageUrl variable
    notifyListeners();

    // todo: update database;
  }

  Future setName(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Сменить имя пользователя',
      textFields: [const DialogTextField(hintText: 'Новое имя')],
    );
    if (result == null || result.isEmpty) return;

    // todo: validate user name
    final isNewUserNameValid = true;
    if (!isNewUserNameValid) {
      Fluttertoast.showToast(
        msg: 'Новое имя пользователя невалидно',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    _userName = result[0];
    notifyListeners();
    // todo: update database
  }

  Future setHandler(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Сменить хэндлер пользователя',
      textFields: [const DialogTextField(hintText: 'Новый хэндлер')],
    );
    if (result == null || result.isEmpty) return;

    // todo: validate handler
    final isNewHandlerValid = true;
    if (!isNewHandlerValid) {
      Fluttertoast.showToast(
        msg: 'Новый хэндлер невалидный',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    // todo: check if new handler is unique
    final isNewHandlerUnique = true;
    if (!isNewHandlerUnique) {
      Fluttertoast.showToast(
        msg: 'Данный хэндлер уже занят',
        backgroundColor: AppColors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    _userHandler = result[0];
    notifyListeners();
    // todo: update database
  }

  Future setIsHiddenAccount(bool value) async {
    await settings.setIsHiddenAccount(value);
    notifyListeners();
  }

  Future setShowProductImages(bool value) async {
    await settings.setShowProductImages(value);
    notifyListeners();
  }

  AuthProvider? get authProvider {
    if (currentUser == null) return null;
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
}

import 'dart:typed_data';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/entities/app_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ErrorType { unknown, input, output }

class UsersDataSource {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _onError([ErrorType errorType = ErrorType.unknown]) {
    final String errorMessage;
    switch (errorType) {
      case ErrorType.unknown:
        errorMessage = 'Произошла неизвестная ошибка';
        break;
      case ErrorType.input:
        errorMessage = 'Произошла ошибка при получении данных';
        break;
      case ErrorType.output:
        errorMessage = 'Произошла ошибка при отправке данных';
        break;
    }
    Fluttertoast.showToast(
      msg: errorMessage,
      backgroundColor: AppColors.red,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Future addAppUser({
    required AppUser appUser,
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).set({
        'name': appUser.name,
        'handler': appUser.handler,
        'avatarUrl': appUser.avatarUrl,
        'isHidden': appUser.isHidden,
        'listIds': appUser.listIds,
        'authProvider': appUser.authProvider,
      }).onError((error, stackTrace) => _onError(ErrorType.output));

  Future<AppUser?> getAppUser({
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).get().then(
        (DataSnapshot snapshot) async {
          try {
            return AppUser.fromJson(
              snapshot.key as String,
              snapshot.value as Map,
            );
          } catch (e) {
            return null;
          }
        },
      ).onError((error, stackTrace) {
        _onError(ErrorType.input);
        return Future.value(null);
      });

  Future<String?> getUserAvatarUrl({
    required String userId,
  }) async {
    try {
      return await _storage
          .ref('avatars')
          .child(userId)
          .getDownloadURL()
          .onError((error, stackTrace) {
        _onError(ErrorType.input);
        return Future.value(null);
      });
    } catch (_) {
      return null;
    }
  }

  Future<String?> uploadAvatarOrNull({
    required Uint8List? bytes,
    required String userId,
  }) async {
    final ref = _storage.ref('avatars').child(userId);
    if (bytes != null) {
      await ref.putData(bytes).onError((error, stackTrace) {
        _onError(ErrorType.output);
        return Future.value(null);
      });
    } else {
      await ref.delete().onError((error, stackTrace) {
        _onError(ErrorType.output);
        return Future.value(null);
      });
    }
    return bytes != null ? await ref.getDownloadURL() : null;
  }

  Future setUserAvatar({
    required Uint8List? bytes,
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).update({
        'avatarUrl': await uploadAvatarOrNull(
          bytes: bytes,
          userId: userId,
        )
      }).onError((error, stackTrace) => _onError(ErrorType.output));

  Future setUserName({
    required String newName,
    required String userId,
  }) async =>
      await _database
          .ref('users')
          .child(userId)
          .update({'name': newName}).onError(
              (error, stackTrace) => _onError(ErrorType.output));

  Future setCurrentAppUserHandler({
    required String handler,
    required String userId,
  }) async =>
      await _database
          .ref('users')
          .child(userId)
          .update({'handler': handler}).onError(
              (error, stackTrace) => _onError(ErrorType.output));

  Future setCurrentAppUserIsHiddenAccount({
    required bool value,
    required String userId,
  }) async =>
      await _database
          .ref('users')
          .child(userId)
          .update({'isHidden': value}).onError(
              (error, stackTrace) => _onError(ErrorType.output));

  Future<AppUser?> fetchAppUserByHandler(String handler) async =>
      await _database.ref('users').get().then((DataSnapshot snapshot) {
        final appUsersMap = snapshot.value as Map;
        for (final appUserId in appUsersMap.keys) {
          final appUser = AppUser.fromJson(appUserId, appUsersMap[appUserId]);
          if (appUser.handler == handler) return appUser;
        }
        return null;
      }).onError((error, stackTrace) {
        _onError(ErrorType.input);
        return null;
      });
}

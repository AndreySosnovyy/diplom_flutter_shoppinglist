import 'dart:typed_data';

import 'package:diplom/features/auth/domain/entities/app_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UsersDataSource {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
      });

  Future<AppUser> getAppUser({
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).get().then(
            (DataSnapshot snapshot) => AppUser.fromJson(
              snapshot.key as String,
              snapshot.value as Map,
            ),
          );

  Future<String?> getUserAvatarUrl({
    required String userId,
  }) async {
    try {
      return await _storage.ref('avatars').child(userId).getDownloadURL();
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
      await ref.putData(bytes);
    } else {
      await ref.delete();
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
      });

  Future setUserName({
    required String newName,
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).update({'name': newName});

  Future setCurrentAppUserHandler({
    required String handler,
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).update({'handler': handler});

  Future setCurrentAppUserIsHiddenAccount({
    required bool value,
    required String userId,
  }) async =>
      await _database.ref('users').child(userId).update({'isHidden': value});

  Future<AppUser?> fetchAppUserByHandler(String handler) async =>
      await _database.ref('users').get().then((DataSnapshot snapshot) {
        final appUsersMap = snapshot.value as Map;
        for (final appUserId in appUsersMap.keys) {
          final appUser = AppUser.fromJson(appUserId, appUsersMap[appUserId]);
          if (appUser.handler == handler) return appUser;
        }
        return null;
      });
}

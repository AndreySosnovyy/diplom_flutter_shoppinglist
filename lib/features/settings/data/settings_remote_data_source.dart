import 'dart:typed_data';

import 'package:diplom/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UsersRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  late final String userId;

  Future init() async {
    assert(auth.currentUser != null);
    userId = auth.currentUser!.uid;
  }

  Future addAppUser(AppUser appUser) async {
    await database.ref('users').child(appUser.id).set({
      'name': appUser.name,
      'handler': appUser.handler,
      'avatarUrl': appUser.avatarUrl,
      'isHidden': appUser.isHidden,
      'listIds': appUser.listIds.toString(),
      'authProvider': appUser.authProvider,
    });
  }

  Future<AppUser> get currentAppUser {
    return database.ref('/users').child('/$userId').get().then(
          (DataSnapshot snapshot) => AppUser.fromJson(
            snapshot.key as String,
            snapshot.value as Map<String, dynamic>,
          ),
        );
  }

  Future<String?> get avatarUrl async {
    try {
      return await storage.ref('avatars/$userId').getDownloadURL();
    } catch (_) {
      return null;
    }
  }

  Future<String?> uploadAvatarOrNull(Uint8List? bytes) async {
    final ref = storage.ref('avatars/$userId');
    if (bytes != null) {
      await ref.putData(bytes);
    } else {
      await ref.delete();
    }
    return bytes != null ? await ref.getDownloadURL() : null;
  }

  Future setCurrentAppUserAvatar(Uint8List? bytes) async => await database
      .ref('/users')
      .child('/$userId')
      .update({'avatarUrl': await uploadAvatarOrNull(bytes)});

  Future setCurrentAppUserName(String newName) async =>
      await database.ref('/users').child('/$userId').update({'name': newName});

  Future setCurrentAppUserHandler(String handler) async => await database
      .ref('/users')
      .child('/$userId')
      .update({'handler': handler});

  Future setCurrentAppUserIsHiddenAccount(bool value) async => await database
      .ref('/users')
      .child('/$userId')
      .update({'isHidden': value});
}

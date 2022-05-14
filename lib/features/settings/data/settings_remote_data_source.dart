import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SettingsRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  // todo: implement method
  Future setAvatar(Uint8List bytes) async => throw UnimplementedError();

  // todo: implement method
  Future setIsHidden(bool value) async => throw UnimplementedError();

  // todo: implement method
  Future setUserHandler(String handler) async => throw UnimplementedError();

  // todo: implement method
  Future setUserName(bool userName) async => throw UnimplementedError();

  // todo: implement method
  Future<String> get avatarUrl async => throw UnimplementedError();

  // todo: implement method
  Future<String> get userName async => throw UnimplementedError();

  // todo: implement method
  Future<String> get userHandler async => throw UnimplementedError();

  // todo: implement method
  Future<bool> get isHidden async => throw UnimplementedError();
}

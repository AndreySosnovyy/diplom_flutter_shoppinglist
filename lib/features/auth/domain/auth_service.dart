import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: ['email']);

  /// Returns firebase user
  Future<User?> signInWithGoogle() async {
    try {
      final signInAccount = await _googleSignIn.signIn();
      final signInAuthentication = await signInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );
      final firebaseAuth = await _auth.signInWithCredential(credential);
      await AppMetrica.setUserProfileID(firebaseAuth.user!.email);
      return firebaseAuth.user;
    } catch (error) {
      return null;
    }
  }

  /// Returns firebase user
  Future<User?> signInWithApple() async => throw UnimplementedError();

  Future<String?> _openCodeScreenAndAwaitForCode() async => await sl
      .get<AppRouter>()
      .push<String>(const SignInWithPhoneCodeViewRoute());

  Future<User?> signInWithPhone({
    required String phone,
    required VoidCallback onErrorCallback,
  }) async {
    if (_auth.currentUser == null) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async =>
            await _auth.signInWithCredential(credential),
        verificationFailed: (FirebaseAuthException e) {
          Logger().e('Phone verification error: ${e.toString()}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          String? smsCode = await _openCodeScreenAndAwaitForCode();
          if (smsCode != null) {
            final credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: smsCode);
            try {
              await _auth.signInWithCredential(credential);
            } catch (e) {
              onErrorCallback();
            }
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      final user = await userStream.firstWhere((user) => user != null);
      await AppMetrica.setUserProfileID(user!.email);
      return user;
    } else {
      return _auth.currentUser;
    }
  }

  bool get isSignedIn => _auth.currentUser != null;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get userStream => _auth.userChanges();

  Future signOut() async => await _auth.signOut();
}

enum AuthProvider { anon, google, apple, phone }

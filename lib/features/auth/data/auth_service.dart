import 'dart:async';

import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
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
      final firebaseAuth = await _firebaseAuth.signInWithCredential(credential);
      return firebaseAuth.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Returns firebase user
  Future<User?> signInWithApple() async {
    return null;
  }

  Future<String?> _openCodeScreenAndAwaitForCode() async => await sl
      .get<AppRouter>()
      .push<String>(const SignInWithPhoneCodeViewRoute());

  Future<User?> signInWithPhone({required String phone}) async {
    if (_firebaseAuth.currentUser == null) {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async =>
            await _firebaseAuth.signInWithCredential(credential),
        verificationFailed: (FirebaseAuthException e) {
          Logger().e('Phone verification error: ${e.toString()}');
          // todo: show error dialog
        },
        codeSent: (String verificationId, int? resendToken) async {
          String? smsCode = await _openCodeScreenAndAwaitForCode();
          if (smsCode != null) {
            final credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: smsCode);
            await _firebaseAuth.signInWithCredential(credential);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return await userStream.firstWhere((user) => user != null);
    } else {
      return _firebaseAuth.currentUser;
    }
  }

  bool get isSignedIn => _firebaseAuth.currentUser != null;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Stream<User?> get userStream => _firebaseAuth.userChanges();

  Future signOut() async => await _firebaseAuth.signOut();
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

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
    }
  }

  /// Returns firebase user
  Future<User?> signInWithApple() async {}

  Future<User?> signInWithPhone({required String phone}) async {}

  bool get isSignedIn => _firebaseAuth.currentUser != null;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Stream<User?> get userStream => _firebaseAuth.userChanges();

  Future signOut() async => await _firebaseAuth.signOut();
}

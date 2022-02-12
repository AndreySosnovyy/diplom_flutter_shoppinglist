import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
  final _router = sl.get<AppRouter>();
  final _auth = sl.get<AuthService>();

  SettingsViewModel() {
    _auth.userStream.listen((_) => notifyListeners());
  }

  void backButtonCallback() => _router.pop();

  void openAuthScreen() => _router.push(const SignInViewRoute());

  Future signOut() async => await _auth.signOut();

  bool get isSignedIn => _auth.isSignedIn;

  User? get currentUser => _auth.currentUser;

  String get displayName =>
      _auth.currentUser?.displayName ?? 'Анонимный пользователь';

  String get displayHandler => '@user_handler';

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

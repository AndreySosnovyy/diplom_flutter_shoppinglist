import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';

import '../../../../workspace/domain/services/remote_data_service.dart';
import '../../../domain/setting_service.dart';

class SettingsViewModel extends BaseViewModel {
  final AppRouter router;
  final AuthService auth;
  final SettingsService settings;

  SettingsViewModel({
    required this.router,
    required this.auth,
    required this.settings,
  }) {
    auth.userStream.listen((user) {
      notifyListeners();
      if (user != null) {
        sl.registerSingleton<RemoteDataService>(RemoteDataService(
          database: FirebaseDatabase.instanceFor(app: Firebase.app()),
          user: auth.currentUser!,
        ));
      } else {
        if (sl.isRegistered<RemoteDataService>()) {
          sl.unregister<RemoteDataService>();
        }
      }
    });
  }

  void backButtonCallback() => router.pop();

  void openAuthScreen() => router.push(const SignInViewRoute());

  Future signOut() async => await auth.signOut();

  bool get isSignedIn => auth.isSignedIn;

  User? get currentUser => auth.currentUser;

  // todo: get name from database
  String get displayName =>
      auth.currentUser?.displayName ?? 'Анонимный пользователь';

  // todo: get handler from database
  String get displayHandler => '@user_handler';

  String get displayVersion => settings.displayVersion;

  void setIsHiddenAccount(bool value) {
    settings.setIsHiddenAccount(value);
    notifyListeners();
  }

  void setShowProductImages(bool value) {
    settings.setShowProductImages(value);
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

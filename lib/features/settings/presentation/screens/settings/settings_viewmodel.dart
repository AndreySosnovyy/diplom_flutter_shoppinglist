import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/data/auth_service.dart';
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
}

import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
  final router = sl.get<AppRouter>();

  void backButtonCallback() => router.pop();

  void openAuthScreen() => router.push(const SignInViewRoute());
}

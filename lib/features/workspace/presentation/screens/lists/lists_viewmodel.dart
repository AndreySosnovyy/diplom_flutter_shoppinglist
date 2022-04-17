import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:flutter/foundation.dart';

class ListsViewModel extends ChangeNotifier {
  ListsViewModel({
    required this.auth,
    required this.router,
  });

  final AuthService auth;
  final AppRouter router;

  // todo: implement method
  String? get userName => null;

  void openSettings() => router.push(const SettingsViewRoute());

  void openListCreationView() => router.push(const ListCreationViewRoute());
}

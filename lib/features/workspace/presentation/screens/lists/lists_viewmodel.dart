import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:flutter/foundation.dart';

class ListsViewModel extends ChangeNotifier {
  final router = sl.get<AppRouter>();

  void openSettings() => router.push(const SettingsViewRoute());

  void openListCreationView() => router.push(const ListCreationViewRoute());
}

import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:flutter/foundation.dart';

class ListsViewModel extends ChangeNotifier {
  void openSettings() => sl.get<AppRouter>().push(const SettingsViewRoute());
}

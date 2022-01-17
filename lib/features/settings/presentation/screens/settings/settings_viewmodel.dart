import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
 void backButtonCallback() => sl.get<AppRouter>().pop();
}
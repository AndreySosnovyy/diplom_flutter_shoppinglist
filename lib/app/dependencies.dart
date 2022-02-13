import 'package:diplom/features/auth/data/auth_service.dart';
import 'package:get_it/get_it.dart';

import '../features/settings/data/setting_service.dart';
import 'navigation/app_router.gr.dart';

final sl = GetIt.instance;

Future setupDependencies() async {
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerSingleton<AppRouter>(AppRouter());
  sl.registerSingleton<SettingsService>(SettingsService());
  await sl.get<SettingsService>().init();
}

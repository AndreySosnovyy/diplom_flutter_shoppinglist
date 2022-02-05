import 'package:diplom/features/auth/data/auth_service.dart';
import 'package:get_it/get_it.dart';

import 'navigation/app_router.gr.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerSingleton<AppRouter>(AppRouter());
}

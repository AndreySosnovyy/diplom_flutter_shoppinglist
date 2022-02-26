import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/services/local_data_service.dart';
import 'package:diplom/features/workspace/domain/services/remote_data_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import '../features/settings/domain/setting_service.dart';
import 'navigation/app_router.gr.dart';

final sl = GetIt.instance;

Future setupDependencies() async {
  sl.registerSingleton<AuthService>(AuthService());
  if (sl.get<AuthService>().currentUser != null) {
    sl.registerSingleton<RemoteDataService>(RemoteDataService(
      database: FirebaseDatabase.instanceFor(app: Firebase.app()),
      user: sl.get<AuthService>().currentUser!,
    ));
  }
  sl.registerSingleton<LocalDataService>(LocalDataService());
  sl.registerSingleton<SettingsService>(SettingsService());
  await sl.get<SettingsService>().init();
  sl.registerSingleton<AppRouter>(AppRouter());
}

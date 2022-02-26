import 'package:diplom/app/values/strings.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/services/local_data_service.dart';
import 'package:diplom/features/workspace/domain/services/remote_data_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

  sl.registerSingleton<LocalDataService>(LocalDataService(
    shoppingListsHiveBox: Hive.box(Strings.shoppingListsBox),
  ));

  sl.registerSingleton<SettingsService>(SettingsService());
  await sl.get<SettingsService>().init();

  sl.registerSingleton<AppRouter>(AppRouter());
}

Future setupSentry() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = Strings.sentryDSN;
      options.tracesSampleRate = 1.0;
    },
  );
}

Future setupHive() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Hive.openBox(Strings.shoppingListsBox);
}

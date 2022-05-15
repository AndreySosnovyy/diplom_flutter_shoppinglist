import 'package:diplom/app/values/strings.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/settings/data/settings_local_data_source.dart';
import 'package:diplom/features/settings/data/settings_remote_data_source.dart';
import 'package:diplom/features/workspace/data/local_workspace_data_source.dart';
import 'package:diplom/features/workspace/data/remote_workspace_data_source.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../features/settings/domain/setting_service.dart';
import 'navigation/app_router.gr.dart';

final sl = GetIt.instance;

Future setupDependencies() async {
  sl.registerSingleton<AuthService>(AuthService());

  sl.registerSingleton<WorkspaceService>(WorkspaceService(
    remoteDataSource: RemoteWorkspaceDataSource(),
    localDataSource: LocalWorkspaceDataSource(),
  ));
  await sl.get<WorkspaceService>().init();

  sl.registerSingleton<SettingsService>(SettingsService(
    usersDataSource: UsersDataSource(),
    localDataSource: SettingsDataSource(),
    auth: FirebaseAuth.instance,
  ));
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

Future setupRemoteDataSources() async {
  sl.registerSingleton<RemoteWorkspaceDataSource>(RemoteWorkspaceDataSource());
  await sl.get<RemoteWorkspaceDataSource>().init();
}

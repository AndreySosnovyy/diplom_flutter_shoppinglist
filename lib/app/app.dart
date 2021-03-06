import 'package:auto_route/auto_route.dart';
import 'package:diplom/core/theme/theme.dart';
import 'package:diplom/core/values/strings.dart';
import 'package:flutter/material.dart';

import 'dependencies.dart';
import 'navigation/app_router.gr.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = sl.get<AppRouter>();

    return MaterialApp.router(
      title: Strings.appName,
      routerDelegate: AutoRouterDelegate(appRouter),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}

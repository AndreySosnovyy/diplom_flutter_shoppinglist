import 'package:auto_route/auto_route.dart';
import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/theme.dart';
import 'package:diplom/app/utils/network_connection.dart';
import 'package:diplom/app/values/strings.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final appRouter = sl.get<AppRouter>();
  final network = NetworkConnectionUtils();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Strings.appName,
      routerDelegate: AutoRouterDelegate(appRouter),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: CommonScrollBehavior(),
    );
  }
}

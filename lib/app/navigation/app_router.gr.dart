// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:diplom/features/auth/presentation/screens/signin/signin_view.dart'
    as _i1;
import 'package:flutter/material.dart' as _i3;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SignInViewRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.SignInView());
    }
  };

  @override
  List<_i2.RouteConfig> get routes =>
      [_i2.RouteConfig(SignInViewRoute.name, path: '/')];
}

/// generated route for
/// [_i1.SignInView]
class SignInViewRoute extends _i2.PageRouteInfo<void> {
  const SignInViewRoute() : super(SignInViewRoute.name, path: '/');

  static const String name = 'SignInViewRoute';
}

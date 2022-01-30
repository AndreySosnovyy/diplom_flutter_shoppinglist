// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart'
    as _i4;
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart'
    as _i3;
import 'package:diplom/features/workspace/presentation/screens/list_creation/list_creation_view.dart'
    as _i2;
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart'
    as _i1;
import 'package:flutter/material.dart' as _i6;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ListsViewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ListsView());
    },
    ListCreationViewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.ListCreationView());
    },
    SettingsViewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SettingsView());
    },
    SignInViewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SignInView());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(ListsViewRoute.name, path: '/'),
        _i5.RouteConfig(ListCreationViewRoute.name,
            path: '/list-creation-view'),
        _i5.RouteConfig(SettingsViewRoute.name, path: '/settings-view'),
        _i5.RouteConfig(SignInViewRoute.name, path: '/sign-in-view')
      ];
}

/// generated route for
/// [_i1.ListsView]
class ListsViewRoute extends _i5.PageRouteInfo<void> {
  const ListsViewRoute() : super(ListsViewRoute.name, path: '/');

  static const String name = 'ListsViewRoute';
}

/// generated route for
/// [_i2.ListCreationView]
class ListCreationViewRoute extends _i5.PageRouteInfo<void> {
  const ListCreationViewRoute()
      : super(ListCreationViewRoute.name, path: '/list-creation-view');

  static const String name = 'ListCreationViewRoute';
}

/// generated route for
/// [_i3.SettingsView]
class SettingsViewRoute extends _i5.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(SettingsViewRoute.name, path: '/settings-view');

  static const String name = 'SettingsViewRoute';
}

/// generated route for
/// [_i4.SignInView]
class SignInViewRoute extends _i5.PageRouteInfo<void> {
  const SignInViewRoute() : super(SignInViewRoute.name, path: '/sign-in-view');

  static const String name = 'SignInViewRoute';
}

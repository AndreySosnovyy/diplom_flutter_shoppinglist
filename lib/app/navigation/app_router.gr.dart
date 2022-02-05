// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart'
    as _i4;
import 'package:diplom/features/auth/presentation/screens/sign_in_with_email_view/sign_in_with_email_view.dart'
    as _i5;
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart'
    as _i3;
import 'package:diplom/features/workspace/presentation/screens/list_creation/list_creation_view.dart'
    as _i2;
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart'
    as _i1;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ListsViewRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ListsView());
    },
    ListCreationViewRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.ListCreationView());
    },
    SettingsViewRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SettingsView());
    },
    SignInViewRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SignInView());
    },
    SignInWithEmailViewRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.SignInWithEmailView());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(ListsViewRoute.name, path: '/'),
        _i6.RouteConfig(ListCreationViewRoute.name,
            path: '/list-creation-view'),
        _i6.RouteConfig(SettingsViewRoute.name, path: '/settings-view'),
        _i6.RouteConfig(SignInViewRoute.name, path: '/sign-in-view'),
        _i6.RouteConfig(SignInWithEmailViewRoute.name,
            path: '/sign-in-with-email-view')
      ];
}

/// generated route for
/// [_i1.ListsView]
class ListsViewRoute extends _i6.PageRouteInfo<void> {
  const ListsViewRoute() : super(ListsViewRoute.name, path: '/');

  static const String name = 'ListsViewRoute';
}

/// generated route for
/// [_i2.ListCreationView]
class ListCreationViewRoute extends _i6.PageRouteInfo<void> {
  const ListCreationViewRoute()
      : super(ListCreationViewRoute.name, path: '/list-creation-view');

  static const String name = 'ListCreationViewRoute';
}

/// generated route for
/// [_i3.SettingsView]
class SettingsViewRoute extends _i6.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(SettingsViewRoute.name, path: '/settings-view');

  static const String name = 'SettingsViewRoute';
}

/// generated route for
/// [_i4.SignInView]
class SignInViewRoute extends _i6.PageRouteInfo<void> {
  const SignInViewRoute() : super(SignInViewRoute.name, path: '/sign-in-view');

  static const String name = 'SignInViewRoute';
}

/// generated route for
/// [_i5.SignInWithEmailView]
class SignInWithEmailViewRoute extends _i6.PageRouteInfo<void> {
  const SignInWithEmailViewRoute()
      : super(SignInWithEmailViewRoute.name, path: '/sign-in-with-email-view');

  static const String name = 'SignInWithEmailViewRoute';
}

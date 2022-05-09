// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart'
    as _i4;
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_code_view.dart'
    as _i6;
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_view.dart'
    as _i5;
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart'
    as _i3;
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart'
    as _i9;
import 'package:diplom/features/workspace/presentation/screens/list_editing/list_editing_view.dart'
    as _i2;
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart'
    as _i1;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:flutter/material.dart' as _i8;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ListsViewRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ListsView());
    },
    ListEditingViewRoute.name: (routeData) {
      final args = routeData.argsAs<ListEditingViewRouteArgs>();
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.ListEditingView(
              saveCallback: args.saveCallback,
              shoppingList: args.shoppingList,
              key: args.key));
    },
    SettingsViewRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SettingsView());
    },
    SignInViewRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SignInView());
    },
    SignInWithPhoneViewRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.SignInWithPhoneView());
    },
    SignInWithPhoneCodeViewRoute.name: (routeData) {
      return _i7.AdaptivePage<String>(
          routeData: routeData, child: const _i6.SignInWithPhoneCodeView());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(ListsViewRoute.name, path: '/'),
        _i7.RouteConfig(ListEditingViewRoute.name, path: '/list-editing-view'),
        _i7.RouteConfig(SettingsViewRoute.name, path: '/settings-view'),
        _i7.RouteConfig(SignInViewRoute.name, path: '/sign-in-view'),
        _i7.RouteConfig(SignInWithPhoneViewRoute.name,
            path: '/sign-in-with-phone-view'),
        _i7.RouteConfig(SignInWithPhoneCodeViewRoute.name,
            path: '/sign-in-with-phone-code-view')
      ];
}

/// generated route for
/// [_i1.ListsView]
class ListsViewRoute extends _i7.PageRouteInfo<void> {
  const ListsViewRoute() : super(ListsViewRoute.name, path: '/');

  static const String name = 'ListsViewRoute';
}

/// generated route for
/// [_i2.ListEditingView]
class ListEditingViewRoute extends _i7.PageRouteInfo<ListEditingViewRouteArgs> {
  ListEditingViewRoute(
      {required dynamic Function(_i9.ShoppingList) saveCallback,
      _i9.ShoppingList? shoppingList,
      _i10.Key? key})
      : super(ListEditingViewRoute.name,
            path: '/list-editing-view',
            args: ListEditingViewRouteArgs(
                saveCallback: saveCallback,
                shoppingList: shoppingList,
                key: key));

  static const String name = 'ListEditingViewRoute';
}

class ListEditingViewRouteArgs {
  const ListEditingViewRouteArgs(
      {required this.saveCallback, this.shoppingList, this.key});

  final dynamic Function(_i9.ShoppingList) saveCallback;

  final _i9.ShoppingList? shoppingList;

  final _i10.Key? key;

  @override
  String toString() {
    return 'ListEditingViewRouteArgs{saveCallback: $saveCallback, shoppingList: $shoppingList, key: $key}';
  }
}

/// generated route for
/// [_i3.SettingsView]
class SettingsViewRoute extends _i7.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(SettingsViewRoute.name, path: '/settings-view');

  static const String name = 'SettingsViewRoute';
}

/// generated route for
/// [_i4.SignInView]
class SignInViewRoute extends _i7.PageRouteInfo<void> {
  const SignInViewRoute() : super(SignInViewRoute.name, path: '/sign-in-view');

  static const String name = 'SignInViewRoute';
}

/// generated route for
/// [_i5.SignInWithPhoneView]
class SignInWithPhoneViewRoute extends _i7.PageRouteInfo<void> {
  const SignInWithPhoneViewRoute()
      : super(SignInWithPhoneViewRoute.name, path: '/sign-in-with-phone-view');

  static const String name = 'SignInWithPhoneViewRoute';
}

/// generated route for
/// [_i6.SignInWithPhoneCodeView]
class SignInWithPhoneCodeViewRoute extends _i7.PageRouteInfo<void> {
  const SignInWithPhoneCodeViewRoute()
      : super(SignInWithPhoneCodeViewRoute.name,
            path: '/sign-in-with-phone-code-view');

  static const String name = 'SignInWithPhoneCodeViewRoute';
}

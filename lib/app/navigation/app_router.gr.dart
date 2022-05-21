// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart'
    as _i5;
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_code_view.dart'
    as _i7;
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_view.dart'
    as _i6;
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart'
    as _i4;
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart'
    as _i10;
import 'package:diplom/features/workspace/presentation/screens/full_screen_image/full_screen_image_view.dart'
    as _i3;
import 'package:diplom/features/workspace/presentation/screens/list_editing/list_editing_view.dart'
    as _i2;
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart'
    as _i1;
import 'package:flutter/material.dart' as _i9;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    ListsViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ListsView());
    },
    ListEditingViewRoute.name: (routeData) {
      final args = routeData.argsAs<ListEditingViewRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.ListEditingView(
              saveCallback: args.saveCallback,
              deleteCallback: args.deleteCallback,
              shoppingList: args.shoppingList,
              key: args.key));
    },
    FullScreenImageViewRoute.name: (routeData) {
      final args = routeData.argsAs<FullScreenImageViewRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData,
          child:
              _i3.FullScreenImageView(imageUrl: args.imageUrl, key: args.key));
    },
    SettingsViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SettingsView());
    },
    SignInViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.SignInView());
    },
    SignInWithPhoneViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.SignInWithPhoneView());
    },
    SignInWithPhoneCodeViewRoute.name: (routeData) {
      return _i8.AdaptivePage<String>(
          routeData: routeData, child: const _i7.SignInWithPhoneCodeView());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(ListsViewRoute.name, path: '/'),
        _i8.RouteConfig(ListEditingViewRoute.name, path: '/list-editing-view'),
        _i8.RouteConfig(FullScreenImageViewRoute.name,
            path: '/full-screen-image-view'),
        _i8.RouteConfig(SettingsViewRoute.name, path: '/settings-view'),
        _i8.RouteConfig(SignInViewRoute.name, path: '/sign-in-view'),
        _i8.RouteConfig(SignInWithPhoneViewRoute.name,
            path: '/sign-in-with-phone-view'),
        _i8.RouteConfig(SignInWithPhoneCodeViewRoute.name,
            path: '/sign-in-with-phone-code-view')
      ];
}

/// generated route for
/// [_i1.ListsView]
class ListsViewRoute extends _i8.PageRouteInfo<void> {
  const ListsViewRoute() : super(ListsViewRoute.name, path: '/');

  static const String name = 'ListsViewRoute';
}

/// generated route for
/// [_i2.ListEditingView]
class ListEditingViewRoute extends _i8.PageRouteInfo<ListEditingViewRouteArgs> {
  ListEditingViewRoute(
      {required dynamic Function(_i10.ShoppingList) saveCallback,
      required dynamic Function(_i10.ShoppingList) deleteCallback,
      _i10.ShoppingList? shoppingList,
      _i9.Key? key})
      : super(ListEditingViewRoute.name,
            path: '/list-editing-view',
            args: ListEditingViewRouteArgs(
                saveCallback: saveCallback,
                deleteCallback: deleteCallback,
                shoppingList: shoppingList,
                key: key));

  static const String name = 'ListEditingViewRoute';
}

class ListEditingViewRouteArgs {
  const ListEditingViewRouteArgs(
      {required this.saveCallback,
      required this.deleteCallback,
      this.shoppingList,
      this.key});

  final dynamic Function(_i10.ShoppingList) saveCallback;

  final dynamic Function(_i10.ShoppingList) deleteCallback;

  final _i10.ShoppingList? shoppingList;

  final _i9.Key? key;

  @override
  String toString() {
    return 'ListEditingViewRouteArgs{saveCallback: $saveCallback, deleteCallback: $deleteCallback, shoppingList: $shoppingList, key: $key}';
  }
}

/// generated route for
/// [_i3.FullScreenImageView]
class FullScreenImageViewRoute
    extends _i8.PageRouteInfo<FullScreenImageViewRouteArgs> {
  FullScreenImageViewRoute({required String imageUrl, _i9.Key? key})
      : super(FullScreenImageViewRoute.name,
            path: '/full-screen-image-view',
            args: FullScreenImageViewRouteArgs(imageUrl: imageUrl, key: key));

  static const String name = 'FullScreenImageViewRoute';
}

class FullScreenImageViewRouteArgs {
  const FullScreenImageViewRouteArgs({required this.imageUrl, this.key});

  final String imageUrl;

  final _i9.Key? key;

  @override
  String toString() {
    return 'FullScreenImageViewRouteArgs{imageUrl: $imageUrl, key: $key}';
  }
}

/// generated route for
/// [_i4.SettingsView]
class SettingsViewRoute extends _i8.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(SettingsViewRoute.name, path: '/settings-view');

  static const String name = 'SettingsViewRoute';
}

/// generated route for
/// [_i5.SignInView]
class SignInViewRoute extends _i8.PageRouteInfo<void> {
  const SignInViewRoute() : super(SignInViewRoute.name, path: '/sign-in-view');

  static const String name = 'SignInViewRoute';
}

/// generated route for
/// [_i6.SignInWithPhoneView]
class SignInWithPhoneViewRoute extends _i8.PageRouteInfo<void> {
  const SignInWithPhoneViewRoute()
      : super(SignInWithPhoneViewRoute.name, path: '/sign-in-with-phone-view');

  static const String name = 'SignInWithPhoneViewRoute';
}

/// generated route for
/// [_i7.SignInWithPhoneCodeView]
class SignInWithPhoneCodeViewRoute extends _i8.PageRouteInfo<void> {
  const SignInWithPhoneCodeViewRoute()
      : super(SignInWithPhoneCodeViewRoute.name,
            path: '/sign-in-with-phone-code-view');

  static const String name = 'SignInWithPhoneCodeViewRoute';
}

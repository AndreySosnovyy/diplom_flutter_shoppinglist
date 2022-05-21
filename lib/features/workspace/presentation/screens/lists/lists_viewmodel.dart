import 'dart:async';

import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsViewModel extends FutureViewModel {
  ListsViewModel({
    required this.auth,
    required this.router,
    required this.workspaceService,
  }) {
    authSubscription = auth.userStream.listen((_) => notifyListeners());
  }

  final AuthService auth;
  final AppRouter router;
  final WorkspaceService workspaceService;
  late final StreamSubscription authSubscription;

  final List<ShoppingList> shoppingLists = <ShoppingList>[];

  final scrollNotifier = ValueNotifier<bool>(false);

  @override
  Future futureToRun() async {
    shoppingLists.addAll(await fetchShoppingLists());
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    authSubscription.cancel();
  }

  // todo: implement method
  Future<List<ShoppingList>> fetchShoppingLists() async {
    return [];
  }

  String? get userName => auth.currentUser?.displayName;

  void openSettings() => router.push(const SettingsViewRoute());

  void openAuthScreen() => router.pushAll([
        const SettingsViewRoute(),
        const SignInViewRoute(),
      ]);

  void setIsPinned({required int productIndex, required bool value}) {
    shoppingLists[productIndex].isPinned = value;
    shoppingLists.sort((a, b) => b.isPinned ? 1 : -1);
    notifyListeners();
  }

  void deleteShoppingList(ShoppingList shoppingList) {
    final index =
        shoppingLists.indexWhere((list) => list.id == shoppingList.id);
    shoppingLists.removeAt(index);
    notifyListeners();
  }

  Future saveShoppingList(ShoppingList shoppingList) async {
    final index =
        shoppingLists.indexWhere((list) => list.id == shoppingList.id);
    if (index == -1) {
      shoppingLists.add(shoppingList);
    } else {
      shoppingLists.removeAt(index);
      shoppingLists.insert(index, shoppingList);
    }
    shoppingLists.sort((a, b) => b.isPinned ? 1 : -1);
    notifyListeners();
  }

  void openListEditingView({ShoppingList? shoppingList}) =>
      router.push(ListEditingViewRoute(
        shoppingList: shoppingList,
        saveCallback: saveShoppingList,
        deleteCallback: deleteShoppingList,
      ));
}

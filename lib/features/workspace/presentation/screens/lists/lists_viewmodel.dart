import 'dart:async';

import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/settings/domain/setting_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class ListsViewModel extends FutureViewModel {
  ListsViewModel({
    required this.auth,
    required this.router,
    required this.workspaceService,
  }) {
    authSubscription = auth.userStream.listen((user) async {
      if (user == null) {
        shoppingLists.clear();
      } else {
        await workspaceService.fetchShoppingLists();
        shoppingLists.clear();
        shoppingLists.addAll(workspaceService.shoppingLists);
      }
      notifyListeners();
    });
  }

  final AuthService auth;
  final AppRouter router;
  final WorkspaceService workspaceService;
  late final StreamSubscription authSubscription;

  final List<ShoppingList> shoppingLists = <ShoppingList>[];

  final scrollNotifier = ValueNotifier<bool>(false);

  @override
  Future futureToRun() async {
    await fetchShoppingLists();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    authSubscription.cancel();
  }

  Future fetchShoppingLists() async {
    await workspaceService.fetchShoppingLists();
    shoppingLists.clear();
    shoppingLists.addAll(workspaceService.shoppingLists);
  }

  String? get userName => auth.currentUser?.displayName;

  void openSettings() => router.push(const SettingsViewRoute());

  void openAuthScreen() => router.pushAll([
        const SettingsViewRoute(),
        const SignInViewRoute(),
      ]);

  Future setIsPinned({required int listIndex, required bool value}) async {
    shoppingLists[listIndex].isPinned = value;
    await workspaceService
        .updateShoppingList(shoppingLists[listIndex]..isPinned = value);
    shoppingLists.sort((a, b) => b.isPinned ? 1 : -1);
    notifyListeners();
  }

  Future deleteShoppingList(ShoppingList shoppingList) async {
    final index =
        shoppingLists.indexWhere((list) => list.id == shoppingList.id);
    shoppingLists.removeAt(index);
    notifyListeners();
    await workspaceService.deleteShoppingList(shoppingList.id);
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
    if (index == -1) {
      workspaceService.addShoppingList(shoppingList);
    } else {
      workspaceService.updateShoppingList(shoppingList);
    }
  }

  void openListEditingView({ShoppingList? shoppingListToOpen}) {
    shoppingListToOpen ??= ShoppingList(id: const Uuid().v1())
      ..color = sl.get<SettingsService>().defaultColor;

    router.push(ListEditingViewRoute(
      shoppingList: shoppingListToOpen,
      saveCallback: saveShoppingList,
      deleteCallback: deleteShoppingList,
    ));
    workspaceService.addShoppingList(shoppingListToOpen);
  }
}

import 'dart:typed_data';

import 'package:diplom/features/workspace/data/remote_workspace_data_source.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkspaceService {
  WorkspaceService({
    required this.remoteDataSource,
    required this.auth,
  });

  final RemoteWorkspaceDataSource remoteDataSource;
  final FirebaseAuth auth;

  final List<ShoppingList> shoppingLists = [];

  Future init() async {
    if (auth.currentUser == null) return;
    shoppingLists.addAll(await remoteDataSource.fetchShoppingLists(
        userId: auth.currentUser!.uid));
  }

  Future<List<ShoppingList>> fetchShoppingLists() async =>
      remoteDataSource.fetchShoppingLists(userId: auth.currentUser!.uid);

  Future addShoppingList(ShoppingList shoppingList) async =>
      remoteDataSource.addShoppingList(
        userId: auth.currentUser!.uid,
        shoppingList: shoppingList,
      );

  Future updateShoppingList(ShoppingList shoppingList) async =>
      remoteDataSource.updateShoppingList(
        userId: auth.currentUser!.uid,
        shoppingList: shoppingList,
      );

  Future deleteShoppingList(String shoppingListId) async =>
      remoteDataSource.deleteShoppingList(
        userId: auth.currentUser!.uid,
        shoppingListId: shoppingListId,
      );

  Future<String> uploadImageAndGetUrl({
    required Uint8List bytes,
    required String shoppingListId,
    required String productName,
  }) async =>
      (await remoteDataSource.uploadImageOrNull(
        bytes: bytes,
        userId: auth.currentUser!.uid,
        shoppingListId: shoppingListId,
        productName: productName,
      ))!;

  Future deleteProductImageFromStorage({
    required String shoppingListId,
    required String productNameId,
  }) async {
    await remoteDataSource.uploadImageOrNull(
      bytes: null,
      userId: auth.currentUser!.uid,
      shoppingListId: shoppingListId,
      productName: productNameId,
    );
  }
}

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
    final result = await remoteDataSource.fetchShoppingLists(
        userId: auth.currentUser!.uid);
    if (result == null) return;
    shoppingLists.addAll(result);
  }

  Future<List<ShoppingList>> fetchShoppingLists() async {
    final result = await remoteDataSource.fetchShoppingLists(
        userId: auth.currentUser!.uid);
    if (result == null) return [];
    shoppingLists.addAll(result);
    return result;
  }

  Future addShoppingList(
    ShoppingList shoppingList, {
    bool forCoAuthor = false,
  }) async {
    // todo: if for co-author
    return remoteDataSource.addShoppingList(
      userId: auth.currentUser!.uid,
      shoppingList: shoppingList,
    );
  }

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
    required String productName,
  }) async {
    await remoteDataSource.uploadImageOrNull(
      bytes: null,
      userId: auth.currentUser!.uid,
      shoppingListId: shoppingListId,
      productName: productName,
    );
  }
}

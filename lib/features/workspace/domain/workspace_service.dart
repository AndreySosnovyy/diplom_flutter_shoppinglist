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
    final listIds = await fetchListIds();
    final result = await remoteDataSource.fetchShoppingLists(listIds);
    if (result == null) return;
    shoppingLists.addAll(result);
  }

  Future fetchShoppingLists() async {
    final listIds = await fetchListIds();
    final result = await remoteDataSource.fetchShoppingLists(listIds);
    if (result == null) return;
    shoppingLists.clear();
    shoppingLists.addAll(result);
    return result;
  }

  Future<List<String>> fetchListIds() async {
    return await remoteDataSource.fetchListIds(userId: auth.currentUser!.uid);
  }

  Future attachListIdToUser({
    required String userId,
    required String listId,
  }) async {
    await remoteDataSource.attachListIdToUser(userId: userId, listId: listId);
  }

  Future addShoppingList(
    ShoppingList shoppingList, {
    String? userId,
  }) async {
    userId ??= auth.currentUser!.uid;
    await remoteDataSource.addShoppingList(shoppingList: shoppingList);
    await remoteDataSource.attachListIdToUser(
      userId: userId,
      listId: shoppingList.id,
    );
  }

  Future updateShoppingList(ShoppingList shoppingList) async =>
      remoteDataSource.updateShoppingList(shoppingList: shoppingList);

  Future deleteShoppingList(String shoppingListId) async {
    remoteDataSource.removeListIdFromUser(
      listId: shoppingListId,
      userId: auth.currentUser!.uid,
    );
  }

  Future<String> uploadImageAndGetUrl({
    required Uint8List bytes,
    required String shoppingListId,
    required String productName,
  }) async =>
      (await remoteDataSource.uploadImageOrNull(
        bytes: bytes,
        shoppingListId: shoppingListId,
        productName: productName,
      ))!;

  Future deleteProductImageFromStorage({
    required String shoppingListId,
    required String productName,
  }) async {
    await remoteDataSource.uploadImageOrNull(
      bytes: null,
      shoppingListId: shoppingListId,
      productName: productName,
    );
  }
}

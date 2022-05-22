import 'dart:typed_data';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/data/settings_remote_data_source.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RemoteWorkspaceDataSource {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _onError([ErrorType errorType = ErrorType.unknown]) {
    final String errorMessage;
    switch (errorType) {
      case ErrorType.unknown:
        errorMessage = 'Произошла неизвестная ошибка';
        break;
      case ErrorType.input:
        errorMessage = 'Произошла ошибка при получении данных';
        break;
      case ErrorType.output:
        errorMessage = 'Произошла ошибка при отправке данных';
        break;
    }
    Fluttertoast.showToast(
      msg: errorMessage,
      backgroundColor: AppColors.red,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Future<String?> uploadImageOrNull({
    required Uint8List? bytes,
    required String userId,
    required String shoppingListId,
    required String productName,
  }) async {
    final ref = _storage
        .ref('product_images/$userId/$shoppingListId')
        .child(productName);
    if (bytes != null) {
      await ref.putData(bytes).onError((error, stackTrace) {
        _onError(ErrorType.output);
        return Future.value(null);
      });
    } else {
      await ref.delete().onError((error, stackTrace) {
        _onError(ErrorType.output);
        return Future.value(null);
      });
    }
    return bytes != null ? await ref.getDownloadURL() : null;
  }

  Future<List<ShoppingList>> fetchShoppingLists({
    required String userId,
  }) async {
    final List<ShoppingList> lists = <ShoppingList>[];
    await _database.ref('lists').child(userId).get().then((snapshot) {
      final listsMap = snapshot.value as Map;
      for (final listId in listsMap.keys) {
        lists.add(ShoppingList.fromJson(listId, listsMap[listId]));
      }
    }).onError((error, stackTrace) {
      _onError(ErrorType.input);
      return Future.value(null);
    });
    return lists;
  }

  Future addShoppingList({
    required String userId,
    required ShoppingList shoppingList,
  }) async {
    await _database
        .ref('lists/$userId')
        .child(shoppingList.id)
        .set(shoppingList.toJson())
        .onError((error, stackTrace) => _onError(ErrorType.output));
  }

  Future updateShoppingList({
    required String userId,
    required ShoppingList shoppingList,
  }) async {
    await _database
        .ref('lists/$userId')
        .child(shoppingList.id)
        .update(shoppingList.toJson())
        .onError((error, stackTrace) => _onError(ErrorType.output));
  }

  Future deleteShoppingList({
    required String userId,
    required String shoppingListId,
  }) async {
    await _database
        .ref('lists/$userId')
        .child(shoppingListId)
        .remove()
        .onError((error, stackTrace) => _onError(ErrorType.output));
  }
}

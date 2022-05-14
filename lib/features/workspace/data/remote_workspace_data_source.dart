import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RemoteWorkspaceDataSource {

  final shoppingLists = <ShoppingList>[];
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future init() async {}

  Future<List<ShoppingList>> fetch() async => throw UnimplementedError();

  Future addShoppingList({
    required ShoppingList shoppingList,
  }) async =>
      throw UnimplementedError();

  Future deleteShoppingList({
    required String shoppingListId,
  }) async =>
      throw UnimplementedError();

  Future addListedProductToShoppingList({
    required shoppingListId,
    required ListedProduct listedProduct,
  }) async =>
      throw UnimplementedError();

  Future deleteListedProductFromShoppingList({
    required shoppingListId,
    required ListedProduct listedProduct,
  }) async =>
      throw UnimplementedError();
}

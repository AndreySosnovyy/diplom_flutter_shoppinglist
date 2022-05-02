import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/services/abstract_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RemoteDataService extends DataService {
  RemoteDataService({
    required this.user,
    required this.database,
  });

  final shoppingLists = <ShoppingList>[];
  final User? user;
  final FirebaseDatabase database;

  @override
  Future<List<ShoppingList>> fetch() async => throw UnimplementedError();

  @override
  Future addShoppingList({
    required ShoppingList shoppingList,
  }) async =>
      throw UnimplementedError();

  @override
  Future deleteShoppingList({
    required String shoppingListId,
  }) async =>
      throw UnimplementedError();

  @override
  Future addListedProductToShoppingList({
    required shoppingListId,
    required ListedProduct listedProduct,
  }) async =>
      throw UnimplementedError();

  @override
  Future deleteListedProductFromShoppingList({
    required shoppingListId,
    required ListedProduct listedProduct,
  }) async =>
      throw UnimplementedError();
}

import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/services/abstract_data_service.dart';

class LocalDataService extends DataService {
  @override
  Future<List<ShoppingList>> fetch() {
    throw UnimplementedError();
  }

  @override
  Future addListedProductToShoppingList({
    required String shoppingListId,
    required ListedProduct listedProduct,
  }) {
    throw UnimplementedError();
  }

  @override
  Future addShoppingList({
    required ShoppingList shoppingList,
  }) {
    throw UnimplementedError();
  }

  @override
  Future deleteListedProductFromShoppingList({
    required String shoppingListId,
    required ListedProduct listedProduct,
  }) {
    throw UnimplementedError();
  }

  @override
  Future deleteShoppingList({
    required String shoppingListId,
  }) {
    throw UnimplementedError();
  }
}

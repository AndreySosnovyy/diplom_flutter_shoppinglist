import '../entities/listed_product.dart';
import '../entities/shopping_list.dart';

abstract class DataService {
  Future<List<ShoppingList>> fetch();

  Future addShoppingList({
    required ShoppingList shoppingList,
  });

  Future deleteShoppingList({
    required String shoppingListId,
  });

  Future addListedProductToShoppingList({
    required String shoppingListId,
    required ListedProduct listedProduct,
  });

  Future deleteListedProductFromShoppingList({
    required String shoppingListId,
    required ListedProduct listedProduct,
  });
}

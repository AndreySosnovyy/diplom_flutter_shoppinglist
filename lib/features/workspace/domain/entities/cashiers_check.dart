import 'package:diplom/features/workspace/domain/entities/bought_product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';

import 'market.dart';

/// The class represents the actual list of products the user has bought
class CashiersCheck {
  final ShoppingList shoppingList;
  final List<BoughtProduct> boughtProducts;
  final DateTime boughtAt;
  final Market market;

  CashiersCheck({
    required this.shoppingList,
    required this.boughtProducts,
    required this.boughtAt,
    required this.market,
  });

  /// Returns the actual total price of all bought products
  /// according to the provided list of bought products
  double get totalPrice => throw UnimplementedError();

  /// Checks if the actually bought date is before the expected shopping list deadline
  bool get isMeetingDeadline {
    if (shoppingList.deadline == null) {
      throw Exception('Provided ShoppingList has no deadline');
    }
    return boughtAt.isBefore(shoppingList.deadline!);
  }

  /// Returns ratio between the number of bought products and number of products
  /// from the shopping list (returns 1 if all products are bought)
  double get boughtProductsRatio =>
      boughtProducts.length / shoppingList.listedProducts.length;

  int get numberOfBoughtProducts => boughtProducts.length;

  int get numberOfListedValues => shoppingList.listedProducts.length;
}

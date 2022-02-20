import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  List<ListedProduct> listedProducts;

  ShoppingList({
    required this.listedProducts,
  });


  /// Returns the expected total price of all products in this list
  /// according to added listed products
  double get expectedTotalPrice => throw UnimplementedError();
}

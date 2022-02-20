import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  List<ListedProduct> listedProducts;
  final List<CoAuthor> coauthors;
  final DateTime? deadline;
  final double? budget;

  ShoppingList({
    required this.listedProducts,
    required this.coauthors,
    this.budget,
    this.deadline,
  });

  /// Returns the expected total price of all products in this list
  /// according to added listed products
  double get expectedTotalPrice => throw UnimplementedError();
}

import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  final String id;
  List<ListedProduct> listedProducts;
  List<CoAuthor> coauthors;
  DateTime? deadline;
  double? budget;
  bool isPinned;

  ShoppingList({
    required this.id,
    this.listedProducts = const [],
    this.coauthors = const [],
    this.budget,
    this.deadline,
    this.isPinned = false,
  });

  /// Returns the expected total price of all products in this list
  /// according to added listed products
  double get expectedTotalPrice => throw UnimplementedError();
}

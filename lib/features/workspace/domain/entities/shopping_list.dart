import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  final String id;
  final List<ListedProduct> listedProducts = [];
  final List<CoAuthor> coAuthors = [];
  DateTime? deadline;
  double? budget;
  bool isPinned = false;

  ShoppingList({required this.id});

  /// Returns the expected total price of all products in this list
  /// according to added listed products
  double get expectedTotalPrice => throw UnimplementedError();
}

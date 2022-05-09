import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  ShoppingList({required this.id});

  final String id;
  late String title = defaultName;
  String? description = null;
  final List<ListedProduct> listedProducts = [];
  final List<CoAuthor> coAuthors = [];
  DateTime? deadline;
  double? budget;
  bool isPinned = false;

  final String defaultName = 'Список покупок';

  /// Returns the expected total price of all products in this list
  /// according to added listed products
  double get expectedTotalPrice => throw UnimplementedError();

  bool get isEmpty {
    if (title != defaultName) return false;
    if (coAuthors.isNotEmpty) return false;
    if (description != null) return false;
    if (listedProducts.isNotEmpty) return false;
    return true;
  }

  bool get isNotEmpty => !isEmpty;
}

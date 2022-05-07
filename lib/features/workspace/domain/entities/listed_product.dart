import 'package:diplom/features/workspace/domain/entities/product.dart';

/// The class represent product wrapped for being used in ShoppingLists
class ListedProduct extends Product {
  final double? expectedPrice;
  final num amount;

  ListedProduct({
    required String name,
    String? description,
    String? imageUrl,
    required Unit unit,
    this.expectedPrice,
    required this.amount,
  }) : super(
          name: name,
          description: description,
          imageUrl: imageUrl,
          unit: unit,
        );
}

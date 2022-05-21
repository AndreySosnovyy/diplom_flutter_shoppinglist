import 'package:diplom/features/workspace/domain/entities/product.dart';

/// The class represent product wrapped for being used in ShoppingLists
class ListedProduct extends Product {
  double? expectedPrice;
  num amount;
  Status status;

  ListedProduct({
    required String name,
    required Unit unit,
    required this.amount,
    this.status = Status.unchecked,
    this.expectedPrice,
    String? description,
    String? imageUrl,
  }) : super(
          name: name,
          description: description,
          imageUrl: imageUrl,
          unit: unit,
        );
}

enum Status { unchecked, checked, unavailable }

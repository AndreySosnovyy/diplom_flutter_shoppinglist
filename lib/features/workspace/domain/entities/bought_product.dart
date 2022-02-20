import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';

/// The class represents one bought product from shopping list
class BoughtProduct extends ListedProduct {
  final double actualPrice;
  final num? actualAmount;

  BoughtProduct({
    required String name,
    String? description,
    required String imageUrl,
    required Unit unit,
    required num amount,
    double? expectedPrice,
    required this.actualPrice,
    this.actualAmount,
  }) : super(
    name: name,
    description: description,
    imageUrl: imageUrl,
    unit: unit,
    amount: amount,
    expectedPrice: expectedPrice,
  );

  /// Returns the difference between actual price and expected price
  double get priceDifference {
    if (expectedPrice == null) throw Exception('expectedPrice has null value');
    return actualPrice - expectedPrice!;
  }

  /// Returns the ratio of the actual price and expected price
  /// (positive value if the actual price is lower than expected and vice versa)
  double get priceRatio {
    if (expectedPrice == null) throw Exception('expectedPrice has null value');
    if (actualPrice <= expectedPrice!) {
      return actualPrice / expectedPrice!;
    } else {
      return -actualPrice / expectedPrice!;
    }
  }
}

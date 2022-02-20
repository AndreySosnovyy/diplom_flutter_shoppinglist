import 'package:diplom/features/workspace/domain/entities/bought_product.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';

import 'market.dart';

/// The class represents the actual list of products the user has bought
class CashiersCheck {
  final List<ListedProduct> listedProducts;
  final List<BoughtProduct> boughtProducts;
  final DateTime boughtAt;
  final Market market;

  CashiersCheck({
    required this.listedProducts,
    required this.boughtProducts,
    required this.boughtAt,
    required this.market,
  });

  /// Returns the actual total price of all bought products
  /// according to the provided list of bought products
  double get totalPrice => throw UnimplementedError();
}

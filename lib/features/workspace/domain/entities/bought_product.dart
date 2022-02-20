import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';

class BoughtProduct extends ListedProduct {
  BoughtProduct(
      {required String name,
      String? description,
      required String imageUrl,
      required Unit unit,
      required double amount})
      : super(
          name: name,
          description: description,
          imageUrl: imageUrl,
          unit: unit,
          amount: amount,
        );
}

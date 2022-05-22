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

  Map toJson() => {
        'name': name,
        'unit': unit.name,
        'amount': amount,
        'status': status.name,
        'imageUrl': imageUrl,
      };

  factory ListedProduct.fromJson(Map json) {
    Status _statusFromString(String statusStr) {
      switch (statusStr) {
        case 'unchecked':
          return Status.unchecked;
        case 'checked':
          return Status.checked;
        case 'unavailable':
          return Status.unavailable;
        default:
          return Status.unchecked;
      }
    }

    Unit _unitFromString(String unitStr) {
      switch (unitStr) {
        case 'pcs':
          return Unit.pcs;
        case 'kilos':
          return Unit.kilos;
        case 'grams':
          return Unit.grams;
        case 'liter':
          return Unit.liter;
        case 'milliliter':
          return Unit.milliliter;
        default:
          return Unit.pcs;
      }
    }

    return ListedProduct(
      name: json['name'],
      unit: _unitFromString(json['unit']),
      amount: json['amount'],
      status: _statusFromString(json['status']),
      imageUrl: json['imageUrl'],
    );
  }
}

enum Status { unchecked, checked, unavailable }

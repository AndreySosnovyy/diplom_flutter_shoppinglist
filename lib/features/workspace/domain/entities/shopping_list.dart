import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:flutter/material.dart';

/// The class represents a list of products the user has created
class ShoppingList {
  ShoppingList({required this.id});

  final String defaultName = 'Список покупок';

  final String id;
  late String title = defaultName;
  String? description;
  final List<ListedProduct> listedProducts = [];
  final List<CoAuthor> coAuthors = [];
  DateTime? deadline;
  double? budget;
  bool isPinned = false;
  late Color color;

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

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'description': description,
        'listedProducts': [
          for (final product in listedProducts) product.toJson()
        ],
        'coAuthors': [for (final coAuthor in coAuthors) coAuthor.toJson()],
        'isPinned': isPinned,
        'color': color.value,
      };

  factory ShoppingList.fromJson(String id, Map json) {
    final List<ListedProduct> products = <ListedProduct>[];
    if (json['listedProducts'] != null) {
      for (final productJson in json['listedProducts']) {
        products.add(ListedProduct.fromJson(productJson));
      }
    }
    final List<CoAuthor> coAuthors = <CoAuthor>[];
    if (json['coAuthors'] != null) {
      for (final coAuthorJson in json['coAuthors']) {
        coAuthors.add(CoAuthor.fromJson(coAuthorJson));
      }
    }
    return ShoppingList(id: id)
      ..title = json['title']
      ..description = json['description']
      ..listedProducts.addAll(products)
      ..coAuthors.addAll(coAuthors)
      ..color = Color(json['color'] as int)
      ..isPinned = json['isPinned'] as bool;
  }
}

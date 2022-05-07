/// The core entity describing product main fields
class Product {
  final String name;
  final String? description;
  final String? imageUrl;
  final Unit unit;

  Product({
    required this.name,
    this.description,
    required this.imageUrl,
    required this.unit,
  });
}

enum Unit { pcs, kilos, grams, liter }
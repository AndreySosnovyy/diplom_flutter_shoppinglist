import 'package:diplom/features/workspace/domain/entities/product.dart';

class Suggestion {
  Suggestion({
    required this.name,
    this.unit = Unit.pcs,
    this.imageUrl,
  });

  final String name;
  final Unit unit;
  final String? imageUrl;
}

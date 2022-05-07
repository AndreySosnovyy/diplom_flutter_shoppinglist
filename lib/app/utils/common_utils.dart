import 'package:diplom/features/workspace/domain/entities/product.dart';

class WorkspaceUtils {
  static String unitToString(Unit unit) {
    switch (unit) {
      case Unit.pcs:
        return 'шт';
      case Unit.kilos:
        return 'кг';
      case Unit.grams:
        return 'гр';
      case Unit.liter:
        return 'л';
    }
  }
}
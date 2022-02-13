import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';

class ListCreationViewModel extends ChangeNotifier {
  final router = sl.get<AppRouter>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final productController = TextEditingController();

  var _screenMode = _ScreenMode.normal;

  void setScreenModeToSearch() {
    _screenMode = _ScreenMode.search;
    notifyListeners();
  }

  void setScreenModeToNormal() {
    _screenMode = _ScreenMode.normal;
    notifyListeners();
  }

  bool get displayTopInputs => _screenMode == _ScreenMode.normal;

  final products = <Product>[];

  void backButtonCallback() => router.pop();

  void onSearchChanged(String text) {}
}

enum _ScreenMode { normal, search }

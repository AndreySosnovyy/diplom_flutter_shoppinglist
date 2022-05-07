import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class ListEditingViewModel extends BaseViewModel {
  ListEditingViewModel({
    required this.router,
    required this.shoppingList,
  }) {
    shoppingList.listedProducts.add(
      ListedProduct(
        name: 'Колбаса',
        unit: Unit.pcs,
        amount: 1,
      ),
    );
  }

  final AppRouter router;
  final ShoppingList shoppingList;

  final ValueNotifier<String> searchNotifier = ValueNotifier('');

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

  void backButtonCallback() => router.pop();

  void onSearchChanged(String text) {
    searchNotifier.value = text;
    notifyListeners();
  }

  // todo: implement method
  void addProductViaSuggestion(Suggestion suggestion) =>
      throw UnimplementedError();

  // todo: implement method
  void addProductByName(String productName) => throw UnimplementedError();

  void incQuantity(int productIndex) {
    shoppingList.listedProducts[productIndex].amount += 1;
    // todo: update database
  }

  void decQuantity(int productIndex) {
    shoppingList.listedProducts[productIndex].amount -= 1;
    if (shoppingList.listedProducts[productIndex].amount == 0) {
      shoppingList.listedProducts.removeAt(productIndex);
      notifyListeners();
    }
    // todo: update database
  }

  Future showAddingCoAuthorDialog(BuildContext context) async {
    final List<String>? result = await showTextInputDialog(
      context: context,
      title: 'Добавить соавтора',
      message: 'Введите хэндлер пользователя',
      okLabel: 'Добавить',
      cancelLabel: 'Назад',
      textFields: [
        const DialogTextField(
          autocorrect: false,
          maxLines: 1,
        )
      ],
    );
    if (result != null && result[0].isNotEmpty) {
      final String userHandler = result[0];
      // todo: check if user exists and his profile is open (+ get his username)
      if (true) {
        shoppingList.coAuthors.add(
          CoAuthor(
            name: 'User name',
            handler: userHandler,
          ),
        );
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: 'Пользователь не был найден',
          backgroundColor: AppColors.red,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  void deleteCoAuthorByUserHandler(String userHandler) {
    shoppingList.coAuthors
        .removeWhere((coAuthor) => coAuthor.handler == userHandler);
    notifyListeners();
  }
}

enum _ScreenMode { normal, search }

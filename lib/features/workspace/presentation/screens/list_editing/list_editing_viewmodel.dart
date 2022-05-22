import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/utils/string_extensions.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/setting_service.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ListEditingViewModel extends FutureViewModel {
  ListEditingViewModel({
    required this.router,
    required this.shoppingList,
    required this.settings,
    required this.imagePicker,
    required this.saveCallback,
    required this.deleteCallback,
    required this.workspaceService,
    required this.settingsService,
  });

  final AppRouter router;
  final ShoppingList shoppingList;
  final SettingsService settings;
  final ImagePicker imagePicker;
  final WorkspaceService workspaceService;
  final SettingsService settingsService;
  final Function(ShoppingList shoppingList) saveCallback;
  final Function(ShoppingList shoppingList) deleteCallback;

  final ValueNotifier<String> searchNotifier = ValueNotifier('');

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final productController = TextEditingController();

  var _screenMode = _ScreenMode.normal;

  @override
  Future futureToRun() => init();

  Future init() async {
    titleController.text =
        shoppingList.title == 'Список покупок' ? '' : shoppingList.title;
    titleController.addListener(() {
      shoppingList.title = titleController.text;
    });
    descriptionController.text =
        shoppingList.description == null ? '' : shoppingList.description!;
    descriptionController.addListener(() {
      shoppingList.description = descriptionController.text;
    });
  }

  void changeColor() {
    final List<Color> availableColors = [
      AppColors.black,
      AppColors.grey2,
      AppColors.red,
      AppColors.green,
      AppColors.blue,
      AppColors.indigo,
      AppColors.orange,
      AppColors.pink,
      AppColors.teal,
      AppColors.jellyBean,
    ];

    shoppingList.color = availableColors[
        (availableColors.indexOf(shoppingList.color) + 1) %
            availableColors.length];
    notifyListeners();
  }

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

  void addProductViaSuggestion(Suggestion suggestion) {
    if (shoppingList.listedProducts
        .where((product) =>
            product.name.toLowerCase() == suggestion.name.toLowerCase())
        .isNotEmpty) {
      incQuantity(shoppingList.listedProducts.indexWhere((product) =>
          product.name.toLowerCase() == suggestion.name.toLowerCase()));
      return;
    }
    shoppingList.listedProducts.add(
      ListedProduct(
        name: suggestion.name,
        unit: suggestion.unit,
        imageUrl: suggestion.imageUrl,
        amount: 1,
      ),
    );
    notifyListeners();
  }

  void addProductByName(String productName) {
    if (shoppingList.listedProducts
        .where((product) =>
            product.name.toLowerCase() == productName.toLowerCase())
        .isNotEmpty) {
      incQuantity(shoppingList.listedProducts.indexWhere((product) =>
          product.name.toLowerCase() == productName.toLowerCase()));
      return;
    }
    shoppingList.listedProducts.add(
      ListedProduct(
        name: productName.capitalize(),
        unit: Unit.pcs,
        amount: 1,
      ),
    );
    notifyListeners();
  }

  Future onProductTap(int index) async {
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
  }

  Future onProductLongPress(int index) async {
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
  }

  Future onUnitTap({
    required BuildContext context,
    required int productIndex,
  }) async {
    final result = await showModalActionSheet(
      context: context,
      title: shoppingList.listedProducts[productIndex].name,
      message: 'Выберите единицу изменения',
      actions: [
        for (final unit in Unit.values)
          SheetAction(
            key: unit,
            label: unitToString(unit),
            isDefaultAction:
                unit == shoppingList.listedProducts[productIndex].unit,
          ),
      ],
    );
    if (result == null) return;

    shoppingList.listedProducts[productIndex].unit = result;
    shoppingList.listedProducts[productIndex].amount = 1;
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
  }

  String unitToString(Unit unit) {
    switch (unit) {
      case Unit.pcs:
        return 'штуки';
      case Unit.kilos:
        return 'килограммы';
      case Unit.grams:
        return 'граммы';
      case Unit.liter:
        return 'литры';
      case Unit.milliliter:
        return 'миллилитры';
    }
  }

  Future onProductImageTap({
    required BuildContext context,
    required int productIndex,
  }) async {
    final result = await showModalActionSheet(
      context: context,
      actions: [
        if (shoppingList.listedProducts[productIndex].imageUrl != null)
          const SheetAction(
            key: _ImageAction.view,
            label: 'Просмотреть фото',
            icon: CupertinoIcons.zoom_in,
            isDefaultAction: true,
          ),
        SheetAction(
          key: _ImageAction.camera,
          label: 'Сделать фото',
          icon: CupertinoIcons.photo_camera,
          isDefaultAction:
              shoppingList.listedProducts[productIndex].imageUrl == null,
        ),
        const SheetAction(
          key: _ImageAction.gallery,
          label: 'Выбрать из галереи',
          icon: CupertinoIcons.photo,
        )
      ],
    );
    if (result == null) return;

    if (result == _ImageAction.view) {
      return router.push(FullScreenImageViewRoute(
          imageUrl: shoppingList.listedProducts[productIndex].imageUrl!));
    }

    final XFile? image = await imagePicker.pickImage(
      source: result == _ImageAction.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      imageQuality: 20,
    );
    if (image == null) return;

    final imageUrl = await workspaceService.uploadImageAndGetUrl(
      bytes: (await image.readAsBytes()),
      shoppingListId: shoppingList.id,
      productName: shoppingList.listedProducts[productIndex].name,
    );
    shoppingList.listedProducts[productIndex].imageUrl = imageUrl;
    notifyListeners();
    workspaceService.updateShoppingList(shoppingList);
  }

  Future incQuantity(int productIndex) async {
    shoppingList.listedProducts[productIndex].amount += 1;
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
  }

  Future decQuantity(int productIndex) async {
    if (shoppingList.listedProducts[productIndex].amount == 1) return;
    shoppingList.listedProducts[productIndex].amount -= 1;
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
  }

  Future deleteProduct(int productIndex) async {
    shoppingList.listedProducts.removeAt(productIndex);
    notifyListeners();
    await workspaceService.updateShoppingList(shoppingList);
    await workspaceService.deleteProductImageFromStorage(
      shoppingListId: shoppingList.id,
      productName: shoppingList.listedProducts[productIndex].name,
    );
  }

  Future saveShoppingList() async {
    if (shoppingList.title == '') shoppingList.title = 'Список покупок';
    saveCallback(shoppingList);
  }

  void deleteShoppingList() {
    router.pop();
    deleteCallback(shoppingList);
  }

  Future showDeleteDialog(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Удаление списка покупок',
      message: 'Вы уверены, что хотите удалить этот список покупок?',
      okLabel: 'Удалить',
      isDestructiveAction: true,
      cancelLabel: 'Отмена',
    );
    if (result == OkCancelResult.ok) deleteShoppingList();
  }

  // todo: add list for co-author
  Future showAddingCoAuthorDialog(BuildContext context) async {
    final List<String>? result = await showTextInputDialog(
      context: context,
      title: 'Добавить соавтора',
      message: 'Введите идентификатор пользователя',
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
      if (settings.userHandler == userHandler) {
        return Fluttertoast.showToast(
          msg: 'Вы не можете добавить себя',
          backgroundColor: AppColors.red,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      if ((shoppingList.coAuthors.where((coAuthor) => coAuthor.handler == userHandler)).isNotEmpty) {
        return Fluttertoast.showToast(
          msg: 'Вы уже добавили этого пользователя',
          backgroundColor: AppColors.red,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      final coAuthor = await settingsService.fetchAppUserByHandler(userHandler);
      if (coAuthor != null) {
        shoppingList.coAuthors.add(
          CoAuthor(
            name: coAuthor.name,
            handler: userHandler,
            avatarUrl: coAuthor.avatarUrl,
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

enum _ImageAction { view, camera, gallery }

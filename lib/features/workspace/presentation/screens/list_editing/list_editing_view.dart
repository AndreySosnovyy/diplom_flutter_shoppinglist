import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/setting_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/adding_products_block.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_search_line.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_textfield.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/empty_banner.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/listed_product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import 'list_editing_viewmodel.dart';

class ListEditingView extends StatelessWidget {
  const ListEditingView({
    required this.saveCallback,
    required this.deleteCallback,
    required this.shoppingList,
    Key? key,
  }) : super(key: key);

  final ShoppingList shoppingList;
  final Function(ShoppingList shoppingList) saveCallback;
  final Function(ShoppingList shoppingList) deleteCallback;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListEditingViewModel>.reactive(
      viewModelBuilder: () {
        final settings = sl.get<SettingsService>();
        return ListEditingViewModel(
          router: sl.get<AppRouter>(),
          shoppingList: shoppingList,
          settings: settings,
          imagePicker: ImagePicker(),
          saveCallback: saveCallback,
          deleteCallback: deleteCallback,
          workspaceService: sl.get<WorkspaceService>(),
          settingsService: sl.get<SettingsService>(),
        );
      },
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          await viewModel.saveShoppingList();
          return true;
        },
        child: Scaffold(
          appBar: CommonAppbar(
            title: shoppingList != null ? 'Редактирование' : 'Новый список',
            trailing: IconButton(
              onPressed: () async => viewModel.showDeleteDialog(context),
              icon: const Icon(
                CupertinoIcons.delete,
                color: AppColors.blue,
              ),
            ),
            leading: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  CupertinoIcons.back,
                  size: 26,
                  color: AppColors.blue,
                ),
                const SizedBox(width: 2),
                Text(
                  'Назад',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.blue),
                ),
              ],
            ),
            leadingCallback: viewModel.backButtonCallback,
          ),
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              viewModel.setScreenModeToNormal();
              FocusManager.instance.primaryFocus?.unfocus();
              viewModel.productController.text = '';
              viewModel.onSearchChanged('');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.displayTopInputs)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 74,
                                  child: CommonTextField(
                                    controller: viewModel.titleController,
                                    hint: 'Название',
                                    isBold: true,
                                    fontSize: 32,
                                    maxLength: 24,
                                    maxLines: 2,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: viewModel.changeColor,
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: viewModel.shoppingList.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CommonTextField(
                              controller: viewModel.descriptionController,
                              hint: 'Описание (необязательно)',
                              fontSize: 18,
                              maxLength: 300,
                              maxLines: 8,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grey3,
                      ),
                      CoAuthorsHandler(
                        coAuthors: viewModel.shoppingList.coAuthors,
                        showAddingCoAuthorDialog: () =>
                            viewModel.showAddingCoAuthorDialog(context),
                        deleteCoAuthor: viewModel.deleteCoAuthorByUserHandler,
                        currentUserHandler: viewModel.settings.userHandler!,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grey3,
                      ),
                    ],
                  ),
                if (!viewModel.displayTopInputs)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.arrow_down,
                          color: AppColors.grey2,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Свернуть',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.grey2),
                        ),
                      ],
                    ),
                  ),
                Center(
                  child: CommonSearchLine(
                    controller: viewModel.productController,
                    onChanged: viewModel.onSearchChanged,
                    hint: 'Название товара',
                    onTap: viewModel.setScreenModeToSearch,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: AddingProductsBlock(
                    searchTextNotifier: viewModel.searchNotifier,
                    onSuggestionTap: viewModel.addProductViaSuggestion,
                    addByProductName: viewModel.addProductByName,
                    showImages: viewModel.settings.showProductImages,
                    showSuggestions: viewModel.settings.showSuggestions,
                  ),
                ),
                viewModel.shoppingList.listedProducts.isEmpty
                    ? const Center(child: EmptyBanner())
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          itemCount:
                              viewModel.shoppingList.listedProducts.length,
                          itemBuilder: (context, index) {
                            return ListedProductTile(
                              index: index,
                              product:
                                  viewModel.shoppingList.listedProducts[index],
                              incQuantityCallback: () =>
                                  viewModel.incQuantity(index),
                              decQuantityCallback: () =>
                                  viewModel.decQuantity(index),
                              onTap: () => viewModel.onProductTap(index),
                              deleteCallback: () =>
                                  viewModel.deleteProduct(index),
                              onLongPress: () =>
                                  viewModel.onProductLongPress(index),
                              onImageTap: () => viewModel.onProductImageTap(
                                context: context,
                                productIndex: index,
                              ),
                              onUnitTap: () => viewModel.onUnitTap(
                                context: context,
                                productIndex: index,
                              ),
                              showImages: viewModel.settings.showProductImages,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

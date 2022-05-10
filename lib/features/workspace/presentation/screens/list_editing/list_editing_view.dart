import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/setting_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_search_line.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_textfield.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/empty_banner.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/listed_product_tile.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/suggestions_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import 'list_editing_viewmodel.dart';

class ListEditingView extends StatelessWidget {
  const ListEditingView({
    required this.saveCallback,
    this.shoppingList,
    Key? key,
  }) : super(key: key);

  final ShoppingList? shoppingList;
  final Function(ShoppingList shoppingList) saveCallback;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListEditingViewModel>.reactive(
      viewModelBuilder: () => ListEditingViewModel(
        router: sl.get<AppRouter>(),
        shoppingList: shoppingList ?? ShoppingList(id: const Uuid().v1()),
        settings: sl.get<SettingsService>(),
        imagePicker: ImagePicker(),
        saveCallback: saveCallback,
      ),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          await viewModel.saveShoppingList();
          return true;
        },
        child: Scaffold(
          appBar: CommonAppbar(
            title: shoppingList != null ? 'Редактирование' : 'Новый список',
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CommonSearchLine(
                      controller: viewModel.productController,
                      onChanged: viewModel.onSearchChanged,
                      hint: 'Название товара',
                      onTap: viewModel.setScreenModeToSearch,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SuggestionsBlock(
                    searchTextNotifier: viewModel.searchNotifier,
                    onSuggestionTap: viewModel.addProductViaSuggestion,
                    addByProductName: viewModel.addProductByName,
                    showImages: viewModel.settings.showProductImages,
                  ),
                ),
                viewModel.shoppingList.listedProducts.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.18),
                          child: const EmptyBanner(),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
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
                            setImageCallback: () => viewModel.setImage(
                              context: context,
                              productIndex: index,
                            ),
                            showImages: viewModel.settings.showProductImages,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

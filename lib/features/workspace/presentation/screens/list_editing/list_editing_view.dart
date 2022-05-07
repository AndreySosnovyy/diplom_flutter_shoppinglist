import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_search_line.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/common_textfield.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/empty_banner.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/listed_product_tile.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/suggestions_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import 'list_editing_viewmodel.dart';

class ListEditingView extends StatelessWidget {
  const ListEditingView({
    this.shoppingList,
    Key? key,
  }) : super(key: key);

  final ShoppingList? shoppingList;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListEditingViewModel>.reactive(
      viewModelBuilder: () => ListEditingViewModel(
        router: sl.get<AppRouter>(),
        shoppingList: shoppingList ?? ShoppingList(id: const Uuid().v1()),
      ),
      builder: (context, viewModel, child) => Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
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
                    children: [
                      CommonTextField(
                        controller: viewModel.nameController,
                        hint: 'Название',
                        isBold: true,
                        fontSize: 38,
                        maxLength: 24,
                      ),
                      CommonTextField(
                        controller: viewModel.descriptionController,
                        hint: 'Описание (необязательно)',
                        fontSize: 20,
                        maxLength: 300,
                        maxLines: 8,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CommonSearchLine(
                    controller: viewModel.productController,
                    onChanged: viewModel.onSearchChanged,
                    hint: 'Название товара',
                    onTap: viewModel.setScreenModeToSearch,
                  ),
                ),
                SuggestionsBlock(
                  searchTextNotifier: viewModel.searchNotifier,
                  onSuggestionTap: viewModel.addProductViaSuggestion,
                  addByProductName: viewModel.addProductByName,
                ),
                viewModel.shoppingList.listedProducts.isEmpty
                    ? const Expanded(child: EmptyBanner())
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: viewModel.shoppingList.listedProducts.length,
                        itemBuilder: (context, index) {
                          return ListedProductTile(
                            index: index,
                            product:
                                viewModel.shoppingList.listedProducts[index],
                            incQuantity: () => viewModel.incQuantity(index),
                            decQuantity: () => viewModel.decQuantity(index),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/common_search_line.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/common_textfield.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/empty_banner.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/suggestions_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'list_creation_viewmodel.dart';

class ListCreationView extends StatelessWidget {
  const ListCreationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListCreationViewModel>.reactive(
      viewModelBuilder: () => ListCreationViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: CommonAppbar(
          title: 'Новый список',
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
                        addCoAuthorCallback: (coAuthor) =>
                            viewModel.coAuthors.add(coAuthor),
                        coAuthors: viewModel.coAuthors,
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
                  suggestionsNotifier: viewModel.suggestionsNotifier,
                ),
                if (viewModel.products.isEmpty)
                  const Expanded(child: EmptyBanner()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

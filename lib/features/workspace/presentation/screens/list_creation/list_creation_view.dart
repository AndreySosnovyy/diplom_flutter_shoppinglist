import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/common_search_line.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/values/assets.dart';
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
          subtitle: 'Андрей Сосновый',
          leading: const Icon(
            CupertinoIcons.back,
            size: 26,
            color: AppColors.blue,
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
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grey3,
                      ),
                      CoAuthorsHandler(
                        addCoAuthorCallback: () {},
                        coAuthors: [
                          CoAuthor(
                            name: 'Андрей Сосновый',
                            handler: '@andreysosnovyy',
                          ),
                          CoAuthor(
                            name: 'Андрей Сосновый',
                            handler: '@andreysosnovyy',
                          ),
                          CoAuthor(
                            name: 'Андрей Сосновый',
                            handler: '@andreysosnovyy',
                            avatarUrl:
                                'https://www.pathwaysvermont.org/wp-content/uploads/2017/03/avatar-placeholder-e1490629554738.png',
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                if (viewModel.products.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.illustrationsEmptyBox,
                          width: 244,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Пока здесь ничего нет',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: AppColors.grey1),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Начните вводить название товара,\nзатем выберете его из списка и укажите количество',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColors.grey2),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 54),
                      ],
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

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/co_authors_handler.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/common_textfield.dart';
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
          subtitle: 'Андрей Сосновый',
          leading: const Icon(
            CupertinoIcons.back,
            size: 26,
            color: AppColors.blue,
          ),
          leadingCallback: viewModel.backButtonCallback,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: AppColors.grey1,
                width: double.infinity,
                height: 1,
              ),
              CoAuthorsHandler(
                addCoAuthorCallback: () {},
                coAuthors: [],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: AppColors.grey1,
                width: double.infinity,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

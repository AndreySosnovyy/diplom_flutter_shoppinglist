import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:diplom/features/workspace/presentation/widgets/shopping_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsView extends StatelessWidget {
  const ListsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const settingsIcon = Icon(
      CupertinoIcons.settings,
      size: 26,
      color: AppColors.blue,
    );

    return ViewModelBuilder<ListsViewModel>.reactive(
      viewModelBuilder: () => ListsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CommonAppbar(
            title: 'Мои списки',
            subtitle: 'Андрей Сосновый',
            hasNameHero: true,
            trailing: settingsIcon,
            trailingCallback: viewModel.openSettings,
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.red,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.green,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.blue,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.indigo,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.yellow,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.pink,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.teal,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description: 'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(),
                    tileColor: ShoppingListTileColors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

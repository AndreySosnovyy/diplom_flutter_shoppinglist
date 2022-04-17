import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/add_list_fab.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/shopping_list_tile.dart';
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
      viewModelBuilder: () => ListsViewModel(
        auth: sl.get<AuthService>(),
        router: sl.get<AppRouter>(),
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CommonAppbar(
            title: 'Мои списки',
            hasNameHero: true,
            trailing: settingsIcon,
            trailingCallback: viewModel.openSettings,
          ),
          floatingActionButton: AddListFAB(
            onPressed: viewModel.openListCreationView,
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.red,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.green,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.blue,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.indigo,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.orange,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.pink,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.teal,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.black,
                  ),
                  ShoppingListTile(
                    title: 'Название',
                    description:
                        'Описание Описание Описание Описание Описание Описание Описание ',
                    shoppingList: ShoppingList(
                      id: '',
                      listedProducts: [],
                      coauthors: [],
                    ),
                    tileColor: ShoppingListTileColors.grey,
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

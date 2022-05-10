import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/services/local_data_service.dart';
import 'package:diplom/features/workspace/domain/services/remote_data_service.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/add_list_fab.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/shopping_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsView extends StatelessWidget {
  const ListsView({
    Key? key,
  }) : super(key: key);

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
        localDataService: sl.get<LocalDataService>(),
        remoteDataService: sl.get<AuthService>().currentUser != null
            ? sl.get<RemoteDataService>()
            : null,
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CommonAppbar(
            title: 'Мои списки',
            trailing: settingsIcon,
            trailingCallback: viewModel.openSettings,
          ),
          floatingActionButton: AddListFAB(
            onPressed: viewModel.openListEditingView,
          ),
          body: Scrollbar(
            child: ScrollConfiguration(
              behavior: CommonScrollBehavior(),
              child: NotificationListener(
                onNotification: (n) {
                  if (n is ScrollStartNotification) {
                    viewModel.scrollNotifier.value = true;
                  } else {
                    if (n is ScrollEndNotification) {
                      viewModel.scrollNotifier.value = false;
                    }
                  }
                  return true;
                },
                child: ListView.separated(
                  itemCount: viewModel.shoppingLists.length,
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 54, left: 16, right: 16),
                  itemBuilder: (context, index) {
                    return ShoppingListTile(
                      scrollNotifier: viewModel.scrollNotifier,
                      shoppingList: viewModel.shoppingLists[index],
                      setIsMarked: (value) => viewModel.setIsPinned(
                        productIndex: index,
                        value: value,
                      ),
                      onTap: () {},
                      onLongPress: () => viewModel.openListEditingView(
                        shoppingList: viewModel.shoppingLists[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

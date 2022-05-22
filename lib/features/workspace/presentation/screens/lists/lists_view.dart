import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/presentation/widgets/common_appbar.dart';
import 'package:diplom/app/presentation/widgets/common_cupertino_button.dart';
import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/workspace_service.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/add_list_fab.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/shopping_list_tile.dart';
import 'package:diplom/generated/assets.dart';
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
        workspaceService: sl.get<WorkspaceService>(),
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
            isClickable: viewModel.auth.currentUser != null,
          ),
          body: viewModel.shoppingLists.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12),
                        Image.asset(
                          Assets.illustrationsCloud,
                          width: MediaQuery.of(context).size.width * 0.66,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Пока здесь пусто',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Вы можете создавать удобные списки покупок и делиться ими.\nВсе изменения сохраняются в облаке',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColors.grey2),
                          textAlign: TextAlign.center,
                        ),
                        if (viewModel.auth.currentUser == null)
                          Column(
                            children: [
                              const SizedBox(height: 54),
                              Text(
                                'Но сперва необходимо авторизоваться,\nчтобы не потерять свои списки:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: AppColors.blue),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 60,
                                child: CommonCupertinoButton(
                                  text: 'Войти   ❯',
                                  onTap: viewModel.openAuthScreen,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              : Scrollbar(
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

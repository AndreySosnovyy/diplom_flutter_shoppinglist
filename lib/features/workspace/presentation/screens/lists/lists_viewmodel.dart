import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/services/local_data_service.dart';
import 'package:diplom/features/workspace/domain/services/remote_data_service.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/widgets/shopping_list_tile.dart';
import 'package:stacked/stacked.dart';

class ListsViewModel extends FutureViewModel {
  ListsViewModel({
    required this.auth,
    required this.router,
    required this.remoteDataService,
    required this.localDataService,
  });

  final AuthService auth;
  final AppRouter router;
  final LocalDataService localDataService;
  final RemoteDataService? remoteDataService;
  final List<ShoppingListTile> shoppingLists = <ShoppingListTile>[];

  @override
  Future futureToRun() async =>
      shoppingLists.addAll(await fetchShoppingLists());

  Future<List<ShoppingListTile>> fetchShoppingLists() async {
    return [
      for (var i = 0; i < 10; i++)
        ShoppingListTile(
          id: '123',
          title: 'Название',
          description:
              'Описание Описание Описание Описание Описание Описание Описание',
          shoppingList: ShoppingList(
            id: '',
            listedProducts: [],
            coauthors: [],
          ),
          tileColor: ShoppingListTileColors.red,
          setIsMarked: (bool isMarked) {},
        ),
    ];
  }

  String? get userName => auth.currentUser?.displayName;

  void openSettings() => router.push(const SettingsViewRoute());

  void openListCreationView() => router.push(const ListEditingViewRoute());
}

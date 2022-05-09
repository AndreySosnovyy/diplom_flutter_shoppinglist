import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/auth/domain/auth_service.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:diplom/features/workspace/domain/services/local_data_service.dart';
import 'package:diplom/features/workspace/domain/services/remote_data_service.dart';
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
  final List<ShoppingList> shoppingLists = <ShoppingList>[];

  @override
  Future futureToRun() async {
    shoppingLists.addAll(await fetchShoppingLists());
    notifyListeners();
  }

  // todo: implement method
  Future<List<ShoppingList>> fetchShoppingLists() async {
    return [];
  }

  String? get userName => auth.currentUser?.displayName;

  void openSettings() => router.push(const SettingsViewRoute());

  Future saveShoppingList(ShoppingList shoppingList) async {
    shoppingLists.add(shoppingList);
    notifyListeners();
  }

  void openListEditingView({ShoppingList? shoppingList}) =>
      router.push(ListEditingViewRoute(
        saveCallback: saveShoppingList,
        shoppingList: shoppingList,
      ));
}

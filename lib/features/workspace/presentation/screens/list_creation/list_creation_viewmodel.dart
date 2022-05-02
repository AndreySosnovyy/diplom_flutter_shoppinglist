import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/workspace/data/suggestions_source.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:flutter/cupertino.dart';

class ListCreationViewModel extends ChangeNotifier {
  final router = sl.get<AppRouter>();

  final List<CoAuthor> coAuthors = <CoAuthor>[
    CoAuthor(
      name: 'Андрей Сосновый',
      handler: '@andreysosnovyy',
    ),
    CoAuthor(
      name: 'Андрей Сосновый',
      handler: '@andreysosnovyy',
    ),
  ];

  final ValueNotifier<List<Suggestion>> suggestionsNotifier = ValueNotifier([]);

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final productController = TextEditingController();
  var _screenMode = _ScreenMode.normal;
  final suggestionsSource = SuggestionsSource();

  void setScreenModeToSearch() {
    _screenMode = _ScreenMode.search;
    notifyListeners();
  }

  void setScreenModeToNormal() {
    _screenMode = _ScreenMode.normal;
    notifyListeners();
  }

  bool get displayTopInputs => _screenMode == _ScreenMode.normal;

  final products = <Product>[];

  void backButtonCallback() => router.pop();

  void onSearchChanged(String text) {
    suggestionsNotifier.value.clear();
    for (final suggestion in suggestionsSource.suggestions) {
      if (suggestion.name
          .toLowerCase()
          .contains(productController.text.toLowerCase())) {
        suggestionsNotifier.value.add(suggestion);
      }
    }
    notifyListeners();
  }
}

enum _ScreenMode { normal, search }

import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsView extends StatelessWidget {
  const ListsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListsViewModel>.reactive(
      viewModelBuilder: () => ListsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Lists view', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}

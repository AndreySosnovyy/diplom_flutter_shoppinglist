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
        appBar: AppBar(),
        body: Center(
          child: Text('List creation view', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}

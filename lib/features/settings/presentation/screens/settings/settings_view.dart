import 'package:diplom/features/settings/presentation/screens/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Settings view', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}

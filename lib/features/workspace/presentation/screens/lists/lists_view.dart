import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsView extends StatelessWidget {
  ListsView({Key? key}) : super(key: key);

  final appbarLeading = ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.palette1.flickrPink,
        AppColors.palette1.purple2,
        AppColors.palette1.vividSkyBlue
      ],
    ).createShader(bounds),
    child: const Icon(
      Icons.arrow_back_ios_rounded,
      size: 26,
    ),
  );

  final appbarTrailing = ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.palette1.flickrPink,
        AppColors.palette1.purple2,
        AppColors.palette1.vividSkyBlue
      ],
    ).createShader(bounds),
    child: const Icon(
      Icons.settings_rounded,
      size: 26,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListsViewModel>.reactive(
      viewModelBuilder: () => ListsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: CommonAppbar(
          title: 'Мои списки',
          subtitle: 'Подзаголовок',
          leading: appbarLeading,
          leadingCallback: () {},
          trailing: appbarTrailing,
          trailingCallback: () {},
        ),
        body: Column(),
      ),
    );
  }
}

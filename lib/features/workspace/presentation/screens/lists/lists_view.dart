import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/common/presentation/widgets/common_appbar.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ListsView extends StatelessWidget {
  const ListsView({Key? key}) : super(key: key);

  Widget wrapInGradient({required Widget child, required List<Color> colors}) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(bounds),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      AppColors.palette1.flickrPink,
      AppColors.palette1.trypanBlue1,
      AppColors.palette1.vividSkyBlue
    ];

    final appbarLeading = wrapInGradient(
      child: const Icon(
        CupertinoIcons.back,
        size: 26,
      ),
      colors: gradientColors,
    );

    final appbarTrailing = wrapInGradient(
      child: const Icon(
        CupertinoIcons.settings,
        size: 26,
      ),
      colors: gradientColors,
    );

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

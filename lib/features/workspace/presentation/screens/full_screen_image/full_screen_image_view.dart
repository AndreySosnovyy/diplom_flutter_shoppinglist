import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/presentation/screens/full_screen_image/full_screen_image_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FullScreenImageViewModel>.reactive(
      viewModelBuilder: () => FullScreenImageViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: Center(
          child: Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (_, __) => const CircularProgressIndicator(
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

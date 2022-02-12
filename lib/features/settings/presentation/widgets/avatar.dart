import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';

import '../../../../app/values/assets.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;
  final bool canBeEdited;

  const Avatar({
    Key? key,
    this.imageUrl,
    this.canBeEdited = false,
    required this.onTap,
  }) : super(key: key);

  Image _buildImage() {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        height: 140.0,
        width: 140.0,
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        Assets.imagesAvatarGrey,
        height: 140.0,
        width: 140.0,
        fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Stack(
        children: [
          _buildImage(),
          if (canBeEdited)
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 140,
                  height: 30,
                  color: AppColors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      'Ред.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

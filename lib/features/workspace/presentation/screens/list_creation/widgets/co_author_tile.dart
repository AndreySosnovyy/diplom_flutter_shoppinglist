import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/generated/assets.dart';
import 'package:flutter/material.dart';

class CoAuthorTile extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final String handler;
  final VoidCallback deleteCallback;

  const CoAuthorTile({
    Key? key,
    this.avatarUrl,
    required this.name,
    required this.handler,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: implement delete button
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            width: 54,
            height: 54,
            child: avatarUrl != null
                ? CachedNetworkImage(
                    imageUrl: avatarUrl!,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    Assets.imagesAvatarGrey,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 4),
            Text(
              handler,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColors.grey1,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

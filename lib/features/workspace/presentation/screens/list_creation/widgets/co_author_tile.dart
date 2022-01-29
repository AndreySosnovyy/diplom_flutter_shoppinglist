import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoAuthorTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String handler;

  const CoAuthorTile({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatarUrl,
            width: 54,
            height: 54,
            fit: BoxFit.fill,
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

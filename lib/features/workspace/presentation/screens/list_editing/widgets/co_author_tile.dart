import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/values/assets.dart';

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
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                color: AppColors.red,
              ),
              SizedBox(width: 8),
              Text(
                'Удалить',
                style: TextStyle(color: AppColors.red),
              ),
            ],
          ),
          onPressed: () {
            deleteCallback();
            Navigator.pop(context);
          },
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                AutoSizeText(
                  name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 4),
                AutoSizeText(
                  handler,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColors.grey1,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

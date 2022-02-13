import 'package:auto_size_text/auto_size_text.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/entities/settings_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final SettingsTileModel content;
  final bool hasBottomBorder;

  final tileHeight = 32.0;
  final tileVerticalPadding = 8.0;

  const SettingsTile({
    Key? key,
    required this.content,
    this.hasBottomBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: content.callback,
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: tileVerticalPadding,
            ),
            child: SizedBox(
              height: tileHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: tileHeight,
                    height: tileHeight,
                    decoration: BoxDecoration(
                      color: content.iconColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: content.icon),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: AutoSizeText(
                      content.title,
                      maxLines: 2,
                      minFontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  content.trailingSwitch ??
                      const Icon(
                        CupertinoIcons.forward,
                        color: AppColors.grey2,
                      ),
                ],
              ),
            ),
          ),
        ),
        if (hasBottomBorder)
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 88,
            color: AppColors.grey2,
          ),
      ],
    );
  }
}

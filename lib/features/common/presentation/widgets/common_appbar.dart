import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? leadingCallback;
  final Widget? trailing;
  final VoidCallback? trailingCallback;
  final bool hasNameHero;

  const CommonAppbar({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.leadingCallback,
    this.trailing,
    this.trailingCallback,
    this.hasNameHero = false,
  })  : height = title == null ? 56 : 102,
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    var subtitleWidget = Text(
      subtitle ?? '',
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: AppColors.grey1),
    );

    return AppBar(
      backgroundColor: AppColors.grey3,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
          child: Container(
            width: 12,
            height: 12,
            color: Colors.transparent,
            child: leading,
          ),
          onTap: leadingCallback),
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: trailing,
          ),
          onTap: trailingCallback,
        ),
      ],
      title: hasNameHero
          ? Hero(tag: 'name', child: subtitleWidget)
          : subtitleWidget,
      bottom: title != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(height),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    Text(title!, style: Theme.of(context).textTheme.headline1),
              ),
            )
          : null,
    );
  }
}

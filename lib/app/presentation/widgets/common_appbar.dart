import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final Widget? leading;
  final VoidCallback? leadingCallback;
  final Widget? trailing;
  final VoidCallback? trailingCallback;
  final bool hasNameHero;
  final Color backgroundColor;

  const CommonAppbar({
    Key? key,
    this.title,
    this.leading,
    this.leadingCallback,
    this.trailing,
    this.trailingCallback,
    this.hasNameHero = false,
    this.backgroundColor = AppColors.grey3,
  })  : height = 56,
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: leading.runtimeType == Row ? 120 : 56,
      leading: GestureDetector(
        onTap: leadingCallback,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 12,
          height: 12,
          color: Colors.transparent,
          child: leading,
        ),
      ),
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.subtitle1,
            )
          : const SizedBox(),
      actions: [
        GestureDetector(
          onTap: trailingCallback,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: trailing,
          ),
        ),
      ],
    );
  }
}

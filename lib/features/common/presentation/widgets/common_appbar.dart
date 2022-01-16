import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? leadingCallback;
  final Widget? trailing;
  final VoidCallback? trailingCallback;

  const CommonAppbar(
      {Key? key,
      required this.title,
      this.subtitle,
      this.leading,
      this.leadingCallback,
      this.trailing,
      this.trailingCallback})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(102);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grey3,
      elevation: 0,
      leading: GestureDetector(child: leading, onTap: leadingCallback),
      actions: [
        GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: trailing,
            ),
            onTap: trailingCallback),
      ],
      title: Text(subtitle ?? '', style: Theme.of(context).textTheme.subtitle1),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(102),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline1),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

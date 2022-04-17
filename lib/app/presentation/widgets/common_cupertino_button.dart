import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonCupertinoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color backgroundColor;

  const CommonCupertinoButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.height = 44,
    this.width = double.infinity,
    this.backgroundColor = AppColors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CupertinoButton(
        color: backgroundColor,
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

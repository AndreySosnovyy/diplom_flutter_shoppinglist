import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInWithMailButton extends StatelessWidget {
  final double height;
  final SignInWithMailButtonStyle style;
  final IconAlignment iconAlignment;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;
  final String text;

  final _mailIconSizeScale = 28 / 44;

  const SignInWithMailButton({
    Key? key,
    required this.onPressed,
    this.height = 44,
    this.style = SignInWithMailButtonStyle.light,
    this.iconAlignment = IconAlignment.left,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.text,
  }) : super(key: key);

  Color get _backgroundColor {
    switch (style) {
      case SignInWithMailButtonStyle.light:
        return AppColors.white;
      case SignInWithMailButtonStyle.dark:
        // return AppColors.orange;
        return AppColors.jellyBean;
    }
  }

  Color get _contrastColor {
    switch (style) {
      case SignInWithMailButtonStyle.light:
        return AppColors.black;
      case SignInWithMailButtonStyle.dark:
        return AppColors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: _contrastColor),
    );

    final mailIcon = SizedBox(
      height: height - 4,
      width: height - 4,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Icon(CupertinoIcons.mail_solid, color: _contrastColor,),
      ),
    );

    var children = <Widget>[];

    switch (iconAlignment) {
      case IconAlignment.center:
        children = [
          mailIcon,
          Flexible(child: textWidget),
        ];
        break;

      case IconAlignment.left:
        children = [
          const SizedBox(width: 12),
          mailIcon,
          Expanded(child: textWidget),
          SizedBox(width: _mailIconSizeScale * height + 24),
        ];
        break;
    }

    return SizedBox(
      height: height,
      child: SizedBox.expand(
        child: CupertinoButton(
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          color: _backgroundColor,
          child: SizedBox(
            height: height,
            child: Row(
              children: children,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

enum SignInWithMailButtonStyle { light, dark }

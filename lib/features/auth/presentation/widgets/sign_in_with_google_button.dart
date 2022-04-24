import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/values/assets.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final double height;
  final SignInWithGoogleButtonStyle style;
  final IconAlignment iconAlignment;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;
  final String text;

  final _googleIconSizeScale = 28 / 44;

  const SignInWithGoogleButton({
    Key? key,
    required this.onPressed,
    this.height = 44,
    this.style = SignInWithGoogleButtonStyle.light,
    this.iconAlignment = IconAlignment.left,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.text,
  }) : super(key: key);

  Color get _backgroundColor {
    switch (style) {
      case SignInWithGoogleButtonStyle.light:
        return AppColors.white;
      case SignInWithGoogleButtonStyle.dark:
        return const Color(0xFF4285F4);
    }
  }

  Color get _contrastColor {
    switch (style) {
      case SignInWithGoogleButtonStyle.light:
        return AppColors.grey1;
      case SignInWithGoogleButtonStyle.dark:
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

    final googleIcon = SizedBox(
      height: height - 4,
      width: height - 4,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          Assets.logosGoogleButton,
          fit: BoxFit.fill,
        ),
      ),
    );

    var children = <Widget>[];

    switch (iconAlignment) {
      case IconAlignment.center:
        children = [
          googleIcon,
          Flexible(child: textWidget),
        ];
        break;

      case IconAlignment.left:
        children = [
          const SizedBox(width: 12),
          googleIcon,
          Expanded(child: textWidget),
          SizedBox(width: _googleIconSizeScale * height + 24),
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

enum SignInWithGoogleButtonStyle { light, dark }

enum IconAlignment { left, center }

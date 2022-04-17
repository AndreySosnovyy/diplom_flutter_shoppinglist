import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonCupertinoDialog extends StatelessWidget {
  final String title;
  final String text;
  final String buttonText;

  const CommonCupertinoDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
      ),
      content: Text(
        text,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.blue),
          ),
        )
      ],
    );
  }
}

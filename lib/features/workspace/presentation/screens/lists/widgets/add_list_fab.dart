import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddListFAB extends StatelessWidget {
  const AddListFAB({
    required this.onPressed,
    required this.isClickable,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isClickable ? onPressed : () {
        Fluttertoast.showToast(
          msg: 'Сперва необходимо авторизоваться',
          backgroundColor: AppColors.red,
          toastLength: Toast.LENGTH_LONG,
        );
      },
      child: const Icon(
        CupertinoIcons.plus,
        color: AppColors.white,
        size: 42,
      ),
      backgroundColor: isClickable ? AppColors.blue : AppColors.grey2,
      heroTag: null,
    );
  }
}

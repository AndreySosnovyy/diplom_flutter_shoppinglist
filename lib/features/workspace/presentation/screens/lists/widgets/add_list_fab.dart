import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddListFAB extends StatelessWidget {
  final VoidCallback onPressed;
  const AddListFAB({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(
        CupertinoIcons.plus,
        color: AppColors.white,
        size: 42,
      ),
      backgroundColor: AppColors.blue,
      heroTag: null,
    );
  }
}

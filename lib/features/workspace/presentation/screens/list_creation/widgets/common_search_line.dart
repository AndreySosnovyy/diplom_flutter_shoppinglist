import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonSearchLine extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function(String text) onChanged;
  final VoidCallback? onTap;

  const CommonSearchLine({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hint,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: MediaQuery.of(context).size.width - 32,
      child: CupertinoSearchTextField(
        onTap: onTap,
        controller: controller,
        onChanged: (value) => onChanged(value),
        backgroundColor: AppColors.grey3,
        placeholder: hint,
        itemSize: 28,
        itemColor: AppColors.grey1,
        suffixIcon: const Icon(
          CupertinoIcons.xmark_circle,
          size: 28,
          color: AppColors.grey1,
        ),
        onSuffixTap: () => controller.text = '',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

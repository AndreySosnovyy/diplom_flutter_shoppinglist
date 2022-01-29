import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isBold;
  final double fontSize;
  final int? maxLines;
  final int? maxLength;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.isBold = false,
    required this.fontSize,
    this.maxLines = 1,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      maxLength: maxLength,
      cursorColor: AppColors.blue,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : null,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : null,
          color: AppColors.grey1,
        ),
      ),
    );
  }
}

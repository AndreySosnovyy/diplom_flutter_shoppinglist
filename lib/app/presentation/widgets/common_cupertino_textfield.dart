import 'package:flutter/cupertino.dart';

class CommonCupertinoTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String errorText;
  final double height;
  final double width;
  final TextInputType? inputType;


  const CommonCupertinoTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.height = 44,
    this.width = double.infinity,
    this.errorText = '',
    this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CupertinoTextField(
        keyboardType: inputType,
        controller: controller,
        placeholder: hint,
      ),
    );
  }
}

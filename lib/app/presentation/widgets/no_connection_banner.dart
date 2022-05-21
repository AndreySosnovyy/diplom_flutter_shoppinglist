import 'dart:ui';

import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoConnectionBanner extends StatelessWidget {
  const NoConnectionBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Center(
        child: Container(
          height: 200,
          width: 240,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 1, color: AppColors.grey3),
            boxShadow: const [
              BoxShadow(
                color: AppColors.grey2,
                spreadRadius: -5,
                blurRadius: 7,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: const [
              Icon(
                FontAwesomeIcons.cloud,
                textDirection: TextDirection.ltr,
                color: AppColors.red,
                size: 54,
              ),
              SizedBox(height: 24),
              Text(
                'Нет соединения\nс интернетом',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

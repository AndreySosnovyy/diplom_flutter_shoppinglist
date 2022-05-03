import 'package:diplom/app/values/assets.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyBanner extends StatelessWidget {
  const EmptyBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.illustrationsEmptyBox,
          width: 244,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(height: 10),
        Text(
          'Пока здесь ничего нет',
          style:
          Theme.of(context).textTheme.subtitle1!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Начните вводить название товара,\nзатем выберете его из списка и укажите количество',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColors.grey1),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 54),
      ],
    );
  }

}
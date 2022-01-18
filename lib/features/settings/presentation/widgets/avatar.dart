import 'package:diplom/app/values/colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Image? image;
  final VoidCallback onTap;

  const Avatar({
    Key? key,
    this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Stack(
        children: [
          image ??
              Image.asset(
                'assets/avatar.png',
                height: 140.0,
                width: 140.0,
              ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 140,
              height: 30,
              color: AppColors.black.withOpacity(0.5),
              child: Center(
                child: Text(
                  'Ред.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

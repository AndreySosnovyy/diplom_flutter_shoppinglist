import 'package:flutter/cupertino.dart';

class GradientIcon extends StatelessWidget {
  final Icon icon;
  final List<Color> colors;

  const GradientIcon({
    Key? key,
    required this.icon,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(bounds),
      child: icon,
    );
  }
}

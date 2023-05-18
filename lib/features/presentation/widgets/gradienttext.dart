import 'package:flutter/material.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

class GradientTextWidget extends StatelessWidget {
  final String textValue;
  final double textSize;
  final FontWeight weight;

  const GradientTextWidget(
      {super.key,
      required this.textValue,
      required this.textSize,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient =  LinearGradient(
      colors: [primaryclr1, primaryclr2],
      begin: Alignment.centerLeft,
      end: Alignment.bottomRight,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 550.0, 80.0));

    return Text(
      textValue,
      style: TextStyle(
          fontSize: textSize,
          fontWeight: weight,
          foreground: Paint()..shader = linearGradient),
    );
  }
}

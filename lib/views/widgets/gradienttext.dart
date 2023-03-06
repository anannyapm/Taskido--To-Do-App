import 'package:flutter/material.dart';

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
    final Shader _linearGradient = const LinearGradient(
      colors: [Color(0xff011638), Color(0xff00a9a5)],
      begin: Alignment.centerLeft,
      end: Alignment.bottomRight,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 550.0, 80.0));

    return Text(
      textValue,
      style: TextStyle(
          fontSize: textSize,
          fontWeight: weight,
          foreground: Paint()..shader = _linearGradient),
    );
  }
}

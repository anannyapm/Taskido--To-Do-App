import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Color colorStart;
  final Color colorEnd;
  final VoidCallback gradFunction;
  final String textVal;
  final Color textColor;

  const GradientBox(
      {super.key,
      this.colorStart = Colors.white,
      this.colorEnd = Colors.white,
      required this.gradFunction,
      required this.textVal,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        gradient: LinearGradient(
          begin: const Alignment(1.392, 4.273),
          end: const Alignment(-2.084, -18.136),
          colors: <Color>[
            colorStart,
            colorEnd,
            // Color.fromARGB(255, 178, 246, 244),
          ],
          stops: const <double>[0, 1],
        ),
      ),
      child: ElevatedButton(
        onPressed: gradFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        ),
        child: Text(
          textVal,
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 22, color: textColor),
        ),
      ),
    );
  }
}

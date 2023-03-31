import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color1,
    required this.text1,
    required this.text2,
    required this.color2,
    
  });
  final Color color1;
  final String text1;
  final String text2;

  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color1,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text1,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color1,
              ),
            )
          ],
        ),

        //secondcolor

        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color2,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text2,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color2,
              ),
            )
          ],
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class HeadingMessage extends StatelessWidget {
  final String heading;
  final String subheading;
  const HeadingMessage(
      {super.key, required this.heading, this.subheading = ""});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Color(0xff011638),
            ),
            children: [
          TextSpan(text: heading),
          TextSpan(
            text: subheading,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              height: 1.5,
              color: Color(0xff011638),
            ),
          ),
        ]));
  }
}

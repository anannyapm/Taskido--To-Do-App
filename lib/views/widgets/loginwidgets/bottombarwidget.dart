import 'package:flutter/material.dart';

class BottomTextButton extends StatelessWidget {
  final String linkText;
  final VoidCallback function;
  const BottomTextButton(
      {super.key, required this.linkText, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        linkText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xff011638),
        ),
      ),
    );
  }
}

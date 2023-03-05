import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final String label;
  const TextFieldWidget({super.key, required this.hint, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
          border: OutlineInputBorder(
            
              borderSide: const BorderSide(width: 1, color: Color(0xbf011638)),
              borderRadius: BorderRadius.circular(15)),
          hintText: hint,
          labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label cannot be Empty!';
        } else
          return null;
      },
    );
  }
}

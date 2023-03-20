import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController textController;
  final TextInputType typeValue;

  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.label,
      required this.textController,
      this.typeValue = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: textController,
        keyboardType: typeValue,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xbf011638)),
                borderRadius: BorderRadius.circular(15)),
            hintText: hint,
            labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be Empty!';
          } else {
            if (typeValue == TextInputType.emailAddress) {
              if (value.contains('@') != true ||
                  value.toLowerCase().contains('.com') != true) {
                return 'Please enter a valid email id!!';
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        },
      ),
    );
  }
}

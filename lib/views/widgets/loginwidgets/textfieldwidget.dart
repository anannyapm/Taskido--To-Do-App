import 'package:flutter/material.dart';
import 'package:todoapp/constants/colorconstants.dart';

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
            fillColor: primaryclr4,
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xbf011638)),
                borderRadius: BorderRadius.circular(15)),
            hintText: hint,
            labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty || value.trim().isEmpty) {
            return '$label cannot be Empty!';
          } else {
            if (typeValue == TextInputType.emailAddress) {
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                return 'Please enter a valid email id!!';
              } else {
                return null;
              }
            } 

            else if (typeValue == TextInputType.text || typeValue == TextInputType.name) {
              if (!RegExp(r'^\S$|^\S[ \S]*\S$').hasMatch(value.trim())) {
                return 'Please enter a valid name!';
              } else {
                return null;
              }
            }
            
            else {
              return null;
            }
          }
        },
      ),
    );
  }
}

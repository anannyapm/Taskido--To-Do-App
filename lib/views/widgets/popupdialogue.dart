import 'package:flutter/material.dart';
import 'package:todoapp/constants/colorconstants.dart';

popupDialogueBox(VoidCallback function, BuildContext ctx, String message) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          title: Text(message),
          titleTextStyle:  TextStyle(
              fontWeight: FontWeight.bold, color: primaryclr3, fontSize: 16),
          actionsOverflowButtonSpacing: 20,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "NO",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            TextButton(
              onPressed: () {
                function();
                Navigator.of(context).pop();
              },
              child:  Text("YES",
                  style: TextStyle(
                      color:dangerColor, fontWeight: FontWeight.w600)),
            ),
            
          ],
        );
      });
}

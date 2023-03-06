import 'package:flutter/material.dart';

popupDialogueBox(
    VoidCallback function, BuildContext ctx,String message) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          title:  Text(message),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black,fontSize: 16),
          actionsOverflowButtonSpacing: 20,
          actions: [
            TextButton(
              
                onPressed: () {
                  function;
                  Navigator.of(context).pop();
                },
                child: const Text("YES",style:TextStyle(color: Colors.red,fontWeight: FontWeight.w600)),),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "NO",style: TextStyle(fontWeight: FontWeight.w600),
                )),
          ],
        );
      });
}

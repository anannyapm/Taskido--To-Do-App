

import 'package:flutter/material.dart';
import 'package:todoapp/constants/colorconstants.dart';

dynamic snackBarWidget(BuildContext ctx,String message,Color colorVal){
  var snackBar =  SnackBar(
        content: Text(message,
          style: TextStyle(color: primaryclr4),
        ),
        backgroundColor: colorVal,
        padding: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      );
      return ScaffoldMessenger.of(ctx)..removeCurrentSnackBar()..showSnackBar(snackBar);
}

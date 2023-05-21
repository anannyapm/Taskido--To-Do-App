

import 'package:flutter/material.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

dynamic snackBarWidget(BuildContext ctx,String message,Color colorVal){
  var snackBar =  SnackBar(
        content: Text(message,
          style: TextStyle(color: primaryclr4),
        ),
        backgroundColor: colorVal,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      );
      return ScaffoldMessenger.of(ctx)..removeCurrentSnackBar()..showSnackBar(snackBar);
}

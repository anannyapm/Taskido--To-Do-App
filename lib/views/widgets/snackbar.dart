

import 'package:flutter/material.dart';

dynamic snackBarWidget(BuildContext ctx,String message,Color colorVal){
  var snackBar =  SnackBar(
        content: Text(message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorVal,
        padding: EdgeInsets.all(20),
        duration: Duration(seconds: 4),
      );
      return ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

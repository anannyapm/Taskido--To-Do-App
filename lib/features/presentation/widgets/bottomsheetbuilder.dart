import 'package:flutter/material.dart';

void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return bottomSheetView;
      },
    );
  }
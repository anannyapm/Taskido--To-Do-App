import 'package:flutter/material.dart';
import 'package:todoapp/constants/colorconstants.dart';

Widget searchBox() {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child:  TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle:const TextStyle(fontSize: 18),
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: primaryclr3,
          ),
          prefixIconConstraints:const BoxConstraints(maxHeight: 20, minWidth: 25)),
    ),
  );
}

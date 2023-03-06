import 'package:flutter/material.dart';

Widget searchBox() {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: const TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 18),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25)),
    ),
  );
}
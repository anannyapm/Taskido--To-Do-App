import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class CategoryClass {
  String taskName;
  Widget taskIcon;
  int taskTotalCount;
  int taskLiveCount;

  CategoryClass({required this.taskName, required this.taskIcon, this.taskLiveCount=0,this.taskTotalCount=0});
}

List<CategoryClass> categoryList = [
      CategoryClass(
          taskName: 'Personal',
          taskIcon: const Icon(FontAwesome.heart,color: Color(0xffF96900),size: 25,),
          taskLiveCount: 6,
          taskTotalCount: 10),
      CategoryClass(
          taskName: 'Work',
          taskIcon: const Icon(FontAwesome.suitcase,color: Color(0xff66635B),size: 25),
          taskLiveCount: 8,
          taskTotalCount: 10),
      
      CategoryClass(
          taskName: 'Movies to Watch',
          taskIcon: const Icon(FontAwesome5.film,color: Color(0xff00A9A5),size: 25),
          taskLiveCount: 0,
          taskTotalCount: 10),
    ];
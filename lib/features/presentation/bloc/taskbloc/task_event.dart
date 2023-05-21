import 'package:flutter/material.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  String taskname;
  int categId;
  DateTime date;
  TimeOfDay time;
  AddTaskEvent(
      {required this.categId,
      required this.taskname,
      required this.date,
      required this.time});
}

class UpdateTaskEvent extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {}

class SearchFilterTaskEvent extends TaskEvent {
  String queryval;
  String filterkey;
  DateTime? date1;
  DateTime? date2;
  int chosedId;

  SearchFilterTaskEvent(
      {this.queryval = "", this.filterkey = "", this.date1, this.date2,this.chosedId=0});
}

class LoadTaskEvent extends TaskEvent {}

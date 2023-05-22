import 'package:flutter/material.dart';

import '../../../data/models/taskmodel.dart';

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

class UpdateTaskEvent extends TaskEvent {
  String taskName;
  TaskModel taskobject;
  DateTime? date;
  TimeOfDay? time;
  UpdateTaskEvent(
      {required this.date,
      required this.taskName,
      required this.taskobject,
      required this.time});
}

class UpdateCompletionEvent extends TaskEvent {
  int taskIndex;
  bool taskValue;
  int categoryIndex;

  UpdateCompletionEvent(
      {required this.categoryIndex,
      required this.taskIndex,
      required this.taskValue});
}

class DeleteTaskEvent extends TaskEvent {
  String taskname;
  int catId;
  DeleteTaskEvent({required this.taskname, required this.catId});
}

class SearchFilterTaskEvent extends TaskEvent {
  String queryval;
  String filterkey;
  DateTime? date1;
  DateTime? date2;
  int chosedId;

  SearchFilterTaskEvent(
      {this.queryval = "",
      this.filterkey = "",
      this.date1,
      this.date2,
      this.chosedId = 0});
}

class LoadTaskEvent extends TaskEvent {}

import 'package:flutter/material.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  String taskname;
  int categId;
  DateTime date;
  TimeOfDay time;
  AddTaskEvent({required this.categId, required this.taskname,required this.date,required this.time});
}

class UpdateTaskEvent extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

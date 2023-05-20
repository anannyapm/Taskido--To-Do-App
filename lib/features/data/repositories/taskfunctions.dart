import 'package:flutter/material.dart';
import 'package:todoapp/features/data/models/taskmodel.dart';

import '../datasources/dbfunctions/categorydbrepo.dart';
import '../datasources/dbfunctions/repository.dart';
import '../datasources/dbfunctions/taskdbrepo.dart';

class TaskFunctionRepo {
  static List<TaskModel> taskModelList = [];
  static List<TaskModel> pendingList = [];

  static Future<dynamic> addTask(
      String task, int ind, DateTime date, TimeOfDay time) async {
    final taskname = task.trim().replaceAll(RegExp(r"\s+"), " ");
    final cidOut = await CategRepository.fetchFirstCid();
    final logoindex = ind == 1 ? cidOut[0]['cid'] : ind;

    final currUserId = Repository.currentUserID;

    final taskObject = TaskModel(
        task_name: taskname,
        isCompleted: 0,
        category_id: logoindex,
        user_id: currUserId,
        task_date_time:
            DateTime(date.year, date.month, date.day, time.hour, time.minute));

    bool out = await TaskRepository.saveData(taskObject);
    return out;
  }

  static getTaskList() async {
    taskModelList.clear();
    final fetchdata=await TaskRepository.getAllData(Repository.currentUserID);
      for (var element in fetchdata) {
        if (element.user_id == Repository.currentUserID) {
          taskModelList.add(element);
          
        }

      }
      setPendingList();
          // notifyListeners();
      return taskModelList;
    }
  

  static setPendingList() {
    pendingList.clear();
    var now = DateTime.now();
    for (var element in taskModelList) {
      if (element.task_date_time
              .isBefore(DateTime(now.year, now.month, now.day + 1)) &&
          element.isCompleted == 0 &&
          element.user_id == Repository.currentUserID) {
        pendingList.add(element);
      }
    }
    if (pendingList.isNotEmpty) {
      pendingList.sort((a, b) => a.task_date_time.compareTo(b.task_date_time));
    }
  }

  static updateTaskValue(
      int taskIndex, bool taskValue, int categoryIndex) async {
    //call db function to update
    final output = await TaskRepository.updateCompletedStatus(
        taskIndex, categoryIndex, Repository.currentUserID, taskValue);
  }
}

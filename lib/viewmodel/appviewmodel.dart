import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/categorymodel.dart';

import 'package:todoapp/models/taskmodel.dart';

import '../dbfunctions/categorydbrepo.dart';
import '../dbfunctions/taskdbrepo.dart';

class AppViewModel extends ChangeNotifier {
  //category actions
  List<CategoryModel> categModelList = <CategoryModel>[];

  Future<void> addCategList() async {
    await CategRepository.getAllData().then((value) {
      categModelList.clear();
      if (value.isEmpty) {
        debugPrint("category count=$categoryCount");
        debugPrint("category completed count=$completedCount");

        notifyListeners();
      }
      for (var map in value) {
        categModelList.add(map);
        debugPrint("category count=$categoryCount");
        debugPrint("category completed count=$completedCount");

        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

  CategoryModel getCategoryListItem(int catIndex) {
    return categModelList[catIndex];
  }

  int get categoryCount {
    int count = 0;
    count = categModelList.length;
    return count;
  }

  //taskdetails

  List<TaskModel> taskModelList = <TaskModel>[];

  Future<void> addTaskList() async {
    await TaskRepository.getAllData().then((value) {
      taskModelList.clear();
      if (value.isEmpty) {
        notifyListeners();
      }
      for (var map in value) {
        debugPrint(map.toString());

        taskModelList.add(map);
        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

//task list based on category

  List<TaskModel> cTaskList = <TaskModel>[];

  Future<void> addCTaskList(int categID) async {
    await TaskRepository.fetchDataWithId(categID, Repository.currentUserID)
        .then((value) {
      cTaskList.clear();
      debugPrint("in add ctask");
      for (var map in value) {
        debugPrint(map.toString());

        cTaskList.add(map);
        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

  getCategoryId(String catName) {
    for (var val in categModelList) {
      debugPrint("in getcategid val " + val.category_name);
      debugPrint("in getcategid catname " + catName);
      debugPrint("i am catgmodel" + val.toString());

      if (val.category_name == catName) {
        debugPrint("in getcategid fun ${val.cid} ");
        return val.cid;
      }
    }
    debugPrint("outside if getcategid fun ");
    return 0;
  }

  TaskModel getCTaskListItem(int taskIndex) {
    return cTaskList[taskIndex];
  }

  TaskModel getTaskListItem(int taskIndex) {
    return taskModelList[taskIndex];
  }

  bool getCTaskValue(int taskIndex) {
    if (cTaskList[taskIndex].isCompleted == 1) {
      return true;
    } else {
      return false;
    }
  }

  int cBasedTaskCount(int catId) {
    int count = 0;
    for (var value in taskModelList) {
      if (value.category_id == catId) {
        count++;
      }
    }
    return count;
  }

  int cBasedCompletdTaskCount(int catId) {
    int count = 0;
    for (var value in taskModelList) {
      if (value.category_id == catId && value.isCompleted == 1) {
        count++;
      }
    }
    return count;
  }

  Future<int> categoryBasedCompletedTaskCount(int catId) async {
    final output = await TaskRepository.fetchCompletedCount(
        catId, Repository.currentUserID);
    return output[0]['count'];
  }

  int get totalTaskCount {
    int counter = 0;
    for (var listval in taskModelList) {
      if (listval.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  Future<void> updateTaskValue(
      int taskIndex, bool taskValue, int categoryIndex) async {
    int taskval = 0;
    if (taskValue == true) {
      taskval = 1;
    }

    //call db function to update
    final output = await TaskRepository.updateCompletedStatus(
        taskIndex, categoryIndex, Repository.currentUserID, taskValue);
    debugPrint("in update$output");
    //addTaskList();
    notifyListeners();
  }

  //old task details

  int get completedCount {
    int counter = 0;
    for (var element in taskModelList) {
      if (element.isCompleted == 1 &&
          element.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  String filterSelection = "";
  DateTime? date1;
  DateTime? date2;
  List<int> filteredList = [];
  void addToFilteredList() {
    if (filterSelection.contains('Today')) {
      DateTime today = DateTime.now();
      filteredList.clear();
      for (var data in taskModelList) {
        if (data.task_date_time.day == today.day &&
            data.task_date_time.month == today.month &&
            data.task_date_time.year == today.year) {
          filteredList.add(data.tid!);
        }
      }
    } else if (filterSelection.contains('Tomorrow')) {
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
      filteredList.clear();
      for (var data in taskModelList) {
        if (data.task_date_time.day == tomorrow.day &&
            data.task_date_time.month == tomorrow.month &&
            data.task_date_time.year == tomorrow.year) {
          filteredList.add(data.tid!);
        }
      }
    } else if (filterSelection.contains('Custom')) {
      filteredList.clear();
      for (var data in taskModelList) {
        if (date1 != null && date2 != null) {
          if (data.task_date_time.isAfter(date1!) &&
              data.task_date_time.isBefore(date2!)) {
            filteredList.add(data.tid!);
          }
        }
      }
    } else if(filterSelection.contains('Clear')) {
      filteredList.clear();
      filterSelection = "";
    }
    notifyListeners();
  }

//active list is not correct
  int get filterTotalTaskCount {
    int counter = 0;
    for (var listval in activeUsableList) {
      if (filteredList.contains(listval.tid) && listval.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  int get filterCompletedCount {
    int counter = 0;
    for (var element in activeUsableList) {
      if (filteredList.contains(element.tid) && element.isCompleted == 1 &&
          element.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  void setDateFilter(DateTime? d1, DateTime? d2) {
    date1 = d1;
    date2 = d2;
    //will be null if date panel closed
    //debugPrint("date selection-" + date1!.toIso8601String()+" "+date2!.toIso8601String());

    notifyListeners();
  }

  void setFilterSelection(String value) {
    filterSelection = value;
    debugPrint("filter selection-" + filterSelection);
    notifyListeners();
  }

//created when chip is selected
  List<TaskModel> activeUsableList = [];

  void setList(List<TaskModel> li) {
    activeUsableList.clear();
    activeUsableList.addAll(li);
    notifyListeners();
  }

//..........CONST COLORS................
  Color primclr1 = const Color(0xff011638);
  Color primclr2 = const Color(0xff00a9a5);
  Color primclr3 = Colors.black;
  Color primclr4 = Colors.white;
  Color iconclr1 = const Color(0xffF96900);
  Color iconclr2 = const Color(0xff00A9A5);
  Color iconclr3 = Colors.blue;
  Color iconclr4 = const Color(0xFF1C0800);

  double progressIndicatorValue(int choosenid) {
    if (choosenid == 0) {
      if (totalTaskCount == 0) {
        return 0;
      } else {
        return completedCount / totalTaskCount;
      }
    } else {
      if (cBasedTaskCount(choosenid) == 0) {
        return 0;
      } else {
        return cBasedCompletdTaskCount(choosenid) / cBasedTaskCount(choosenid);
      }
    }
  }

  void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return bottomSheetView;
      },
    );
  }

  File? profilePhoto;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
    } else {
      final photoTemp = File(photo.path);
      profilePhoto = photoTemp;
      notifyListeners();
    }
  }
}

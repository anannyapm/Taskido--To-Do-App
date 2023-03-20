import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/categorymodel.dart';

import 'package:todoapp/models/taskmodel.dart';

import '../dbfunctions/categorydbrepo.dart';
import '../dbfunctions/taskdbrepo.dart';

class AppViewModel extends ChangeNotifier {
  int selectedIndexNotifier = 0;
  void notifyOnIndexChange(int index) {
    selectedIndexNotifier = index;
    notifyListeners();
  }
  //category operations

  List<CategoryModel> categModelList = <CategoryModel>[];

  //create category model list

  Future<void> addToCategList() async {
    await CategRepository.getAllData().then((value) {
      categModelList.clear();
      //notigying listner in case of no data in value
      if (value.isEmpty) {
        notifyListeners();
      }
      for (var map in value) {
        categModelList.add(map);
        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

  int get categoryCount {
    int count = 0;
    count = categModelList.length;
    return count;
  }

  //taskdetails

  List<TaskModel> taskModelList = <TaskModel>[];

  //add to taskModel list
  Future<void> addToTaskList() async {
    await TaskRepository.getAllData(Repository.currentUserID).then((value) {
      taskModelList.clear();
      if (value.isEmpty) {
        notifyListeners();
      }
      for (var map in value) {
        if (map.user_id == Repository.currentUserID) {
          

          taskModelList.add(map);
          notifyListeners();
        }
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

  getCategoryId(String catName) {
    for (var val in categModelList) {
      if (val.category_name == catName) {
        return val.cid;
      }
    }
    return 0;
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

  int get totalTaskCount {
    int counter = 0;
    for (var listval in taskModelList) {
      if (listval.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

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

  Future<void> updateTaskValue(
      int taskIndex, bool taskValue, int categoryIndex) async {
    //call db function to update
    final output = await TaskRepository.updateCompletedStatus(
        taskIndex, categoryIndex, Repository.currentUserID, taskValue);
    debugPrint("Task update done! $output");

    notifyListeners();
  }

  //Search anf Filter operations

  List queryResultList = [];
  String queryval = '';
  addToQueryList(String query) async {
    queryResultList.clear();

    if (query.isEmpty || query == '') {
      queryResultList.clear();
    } else {
      for (var element in taskModelList) {
        if (element.task_name
            .toLowerCase()
            .contains(query.trim().toLowerCase())) {
          queryResultList.add(element.task_name);
        }
      }
      debugPrint("Query result contains: $queryResultList");
    }
    notifyListeners();
  }

  String filterSelection = "";
  String displayFilterDetail = "";
  DateTime? date1;
  DateTime? date2;

  void setDateFilter(DateTime? d1, DateTime? d2) {
    date1 = d1;
    date2 = d2;

    notifyListeners();
  }

  void setFilterSelection(String value) {
    filterSelection = value;
    debugPrint("Filter Enabled for $filterSelection");
    notifyListeners();
  }

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
          displayFilterDetail = DateFormat('EEE, M/d/y').format(today);
        }
      }
    } else if (filterSelection.contains('Tomorrow')) {
      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
      filteredList.clear();
      for (var data in taskModelList) {
        if (data.task_date_time.day == tomorrow.day &&
            data.task_date_time.month == tomorrow.month &&
            data.task_date_time.year == tomorrow.year) {
          filteredList.add(data.tid!);
          displayFilterDetail = DateFormat('EEE, M/d/y').format(tomorrow);
        }
      }
    } else if (filterSelection.contains('Custom')) {
      filteredList.clear();
      for (var data in taskModelList) {
        if (date1 != null && date2 != null) {
          if (data.task_date_time.isAfter(date1!) &&
              data.task_date_time.isBefore(date2!)) {
            filteredList.add(data.tid!);
            displayFilterDetail =
                "${DateFormat('EEE, M/d/y').format(date1!)} to ${DateFormat('EEE, M/d/y').format(date2!)}";
          }
        } else {
          displayFilterDetail = "No date range selected";
        }
      }
    } else if (filterSelection.contains('Clear')) {
      filteredList.clear();
      filterSelection = "";
      date1 = null;
      date2 = null;
      displayFilterDetail = "";
    }
    notifyListeners();
  }

  int filterTotalTaskCount(int chosenid) {
    int counter = 0;

    for (var listval in taskModelList) {
      if (chosenid != 0) {
        if (filteredList.contains(listval.tid) &&
            listval.user_id == Repository.currentUserID &&
            listval.category_id == chosenid) {
          counter++;
        }
      } else {
        if (filteredList.contains(listval.tid) &&
            listval.user_id == Repository.currentUserID) {
          counter++;
        }
      }
    }
    return counter;
  }

  int filterCompletedCount(int chosenid) {
    int counter = 0;
    for (var element in taskModelList) {
      if (chosenid != 0) {
        if (filteredList.contains(element.tid) &&
            element.category_id == chosenid &&
            element.isCompleted == 1 &&
            element.user_id == Repository.currentUserID) {
          counter++;
        }
      } else {
        if (filteredList.contains(element.tid) &&
            element.isCompleted == 1 &&
            element.user_id == Repository.currentUserID) {
          counter++;
        }
      }
    }
    return counter;
  }

  //set values to total and completed count values based on different conditions
  Map<String, int> setCountValues(int chosenid) {
    Map<String, int> result;
    if (filterSelection == "") {
      if (chosenid == 0) {
        result = {'Total': totalTaskCount, 'Completed': completedCount};
      } else {
        result = {
          'Total': cBasedTaskCount(chosenid),
          'Completed': cBasedCompletdTaskCount(chosenid)
        };
      }
    } else {
      result = {
        'Total': filterTotalTaskCount(chosenid),
        'Completed': filterCompletedCount(chosenid)
      };
    }

    return result;
  }

  double progressIndicatorValue(int choosenid) {
    if (filterSelection == "") {
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
          return cBasedCompletdTaskCount(choosenid) /
              cBasedTaskCount(choosenid);
        }
      }
    } else {
      if (filterTotalTaskCount(choosenid) == 0) {
        return 0;
      } else {
        return filterCompletedCount(choosenid) /
            filterTotalTaskCount(choosenid);
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

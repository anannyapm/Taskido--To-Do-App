import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/features/data/models/taskmodel.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';

import '../datasources/dbfunctions/categorydbrepo.dart';
import '../datasources/dbfunctions/repository.dart';
import '../datasources/dbfunctions/taskdbrepo.dart';

class TaskFunctionRepo {
  static List<TaskModel> taskModelList = [];
  static List<TaskModel> pendingList = [];

  static Future<bool> addTask(
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

  static Future<dynamic> getTaskList() async {
    taskModelList.clear();
    final fetchdata = await TaskRepository.getAllData(Repository.currentUserID);
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

  static int todayTotalTasks(int catId) {
    int count = 0;
    var now = DateTime.now();
    for (var value in taskModelList) {
      if (value.task_date_time
              .isBefore(DateTime(now.year, now.month, now.day + 1)) &&
          value.category_id == catId) {
        count++;
      }
    }
    return count;
  }

  static int pendingTodayCount(int catId) {
    int count = 0;
    for (var value in pendingList) {
      if (value.category_id == catId) {
        count++;
      }
    }
    return count;
  }

  static int cBasedTaskCount(int catId) {
    int count = 0;
    for (var value in taskModelList) {
      if (value.category_id == catId) {
        count++;
      }
    }
    return count;
  }

  static int cBasedCompletdTaskCount(int catId) {
    int count = 0;
    for (var value in taskModelList) {
      if (value.category_id == catId && value.isCompleted == 1) {
        count++;
      }
    }
    return count;
  }

  static int get totalTaskCount {
    int counter = 0;
    for (var listval in taskModelList) {
      if (listval.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  static int get completedCount {
    int counter = 0;
    for (var element in taskModelList) {
      if (element.isCompleted == 1 &&
          element.user_id == Repository.currentUserID) {
        counter++;
      }
    }
    return counter;
  }

  static updateTaskValue(
      int taskIndex, bool taskValue, int categoryIndex) async {
    //call db function to update
  }

  //Search and Filter operations

  static List queryResultList = [];
  static String queryval = '';
  static addToQueryList(String query)  {
    queryResultList.clear();

    if (query.isEmpty || query == '') {
      queryResultList.clear();
    } else {
      for (var element in taskModelList) {
        if (element.task_name
            .trim()
            .removeAllWhitespace()
            .toLowerCase()
            .contains(query.trim().removeAllWhitespace().toLowerCase())) {
          queryResultList.add(element.task_name);
        }
      }
    }
    return queryResultList;
  }

  static String filterSelection = "";
  static String displayFilterDetail = "";
  static DateTime? date1;
  static DateTime? date2;

  static void setDateFilter(DateTime? d1, DateTime? d2) {
    date1 = d1;
    date2 = d2;
  }

  static void setFilterSelection(String value) {
    filterSelection = value;
  }

  static List<int> filteredList = [];
  static addToFilteredList() {
    if (filterSelection.contains('Today')) {
      setDateFilter(null, null);

      DateTime today = DateTime.now();
      filteredList.clear();
      for (var data in taskModelList) {
        if (data.task_date_time.day == today.day &&
            data.task_date_time.month == today.month &&
            data.task_date_time.year == today.year) {
          filteredList.add(data.tid!);
        }
      }
      displayFilterDetail = DateFormat('EEE, M/d/y').format(today);
    } else if (filterSelection.contains('Tomorrow')) {
      setDateFilter(null, null);

      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
      filteredList.clear();
      for (var data in taskModelList) {
        if (data.task_date_time.day == tomorrow.day &&
            data.task_date_time.month == tomorrow.month &&
            data.task_date_time.year == tomorrow.year) {
          filteredList.add(data.tid!);
        }
      }
      displayFilterDetail = DateFormat('EEE, M/d/y').format(tomorrow);
    } else if (filterSelection.contains('Custom')) {
      filteredList.clear();
      for (var data in taskModelList) {
        if (date1 != null && date2 != null) {
          if (date1 == date2) {
            if (data.task_date_time.day == date1!.day &&
                data.task_date_time.month == date1!.month &&
                data.task_date_time.year == date1!.year) {
              filteredList.add(data.tid!);
            }
            displayFilterDetail = DateFormat('EEE, M/d/y').format(date1!);
          } else {
            if (data.task_date_time.isAfter(date1!) &&
                data.task_date_time.isBefore(date2!)) {
              filteredList.add(data.tid!);
            }
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

    return filteredList;
  }

  static int filterTotalTaskCount(int chosenid) {
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

  static int filterCompletedCount(int chosenid) {
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
  static Map<String, int> setCountValues(int chosenid) {
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

    print(result);
    return result;
  }

  static double progressIndicatorValue(int choosenid) {
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
}

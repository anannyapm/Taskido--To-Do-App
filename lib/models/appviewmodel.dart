import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/models/oldtaskmodel.dart';
import 'package:todoapp/models/taskmodel.dart';

import '../dbfunctions/categorydbrepo.dart';
import '../dbfunctions/taskdbrepo.dart';

class AppViewModel extends ChangeNotifier {
  //category actions
  List<CategoryModel> categModelList = <CategoryModel>[];

  /*  void addCategoryList(CategoryModel Value) {
    //categModelList.clear();
    
      categModelList.add(Value);
      notifyListeners();
    } */

  Future<void> addCategList() async {
    await CategRepository.getAllData().then((value) {
      categModelList.clear();
      for (var map in value) {
        //debugPrint("In addcateglist" + map.category_name);
        //getCategoryId(map.category_name);

        categModelList.add(map);
        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

  CategoryModel getCategoryListItem(int catIndex) {
    return categModelList[catIndex];
  }

  int get categoryCount => categModelList.length;

  //taskdetails

  List<TaskModel> taskModelList = <TaskModel>[];

  Future<void> addTaskList() async {
    await TaskRepository.getAllData().then((value) {
      taskModelList.clear();
      for (var map in value) {
        debugPrint(map.toString());

        taskModelList.add(map);
        notifyListeners();
      }
    }).catchError((e) => debugPrint(e.toString()));
  }

//list based on category

  List<TaskModel> cTaskList = <TaskModel>[];

  Future<void> addCTaskList(int categID) async {
    await TaskRepository.fetchDataWithId(categID, Repository.currentUserID)
        .then((value) {
      cTaskList.clear();
      for (var map in value) {
        debugPrint(map.toString());

        cTaskList.add(TaskModel.fromMap(map));
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
  /*  int categoryBasedTaskCount(int catId) async {
    //final output =
    await TaskRepository.fetchCount(catId, Repository.currentUserID)
        .then((value) {
      return value[0]['count'];
    }).catchError((e) {
      
      debugPrint(e.toString());
      return 0;
    });
  } */

  Future<int> categoryBasedCompletedTaskCount(int catId) async {
    final output = await TaskRepository.fetchCompletedCount(
        catId, Repository.currentUserID);
    return output[0]['count'];
  }

  int get totalTaskCount => taskModelList.length;

  Future<void> updateTaskValue(int taskIndex, bool taskValue, int categoryIndex) async{
    int taskval = 0;
    if (taskValue == true) {
      taskval = 1;
    }
    //cTaskList[taskIndex].isCompleted = taskval;
    //call db function to update
    final output =await TaskRepository.updateCompletedStatus(
        taskIndex, categoryIndex, Repository.currentUserID, taskValue);
    debugPrint("in update$output");
    //addTaskList();
    notifyListeners();
  }

  //old task details

  List<Task> taskList = <Task>[];
  //User user = User('Greta');

  int get taskCount => taskList.length;

  List<Map<String, dynamic>> currentUserData = <Map<String, dynamic>>[];

  int get completedCount {
    int counter = 0;
    for (var element in taskList) {
      if (element.isCompleted == true) {
        counter++;
      }
    }
    return counter;
  }

  Color primclr1 = const Color(0xff011638);
  Color primclr2 = const Color(0xff00a9a5);
  Color primclr3 = Colors.black;
  Color primclr4 = Colors.white;
  Color iconclr1 = const Color(0xffF96900);
  Color iconclr2 = const Color(0xff00A9A5);
  Color iconclr3 = Colors.blue;
  Color iconclr4 = const Color(0xFF1C0800);

  void addTask(Task newTask) {
    taskList.add(newTask);

    notifyListeners();
  }

  bool getTaskValue(int taskIndex) {
    return taskList[taskIndex].isCompleted;
  }

  void setTaskValue(int taskIndex, bool taskValue) {
    taskList[taskIndex].isCompleted = taskValue;
    notifyListeners();
  }

  String getTaskTitle(int taskIndex) {
    return taskList[taskIndex].title;
  }

  String getCategory(int taskIndex) {
    return taskList[taskIndex].categoryname;
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

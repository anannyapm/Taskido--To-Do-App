import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/models/taskmodel.dart';

class AppViewModel extends ChangeNotifier {
  //category actions
  List<CategoryModel> categModelList = <CategoryModel>[];

  addCategoryList(List mapValue) {
    categModelList.clear();
    for (var map in mapValue) {
      debugPrint(map.toString());
      final category = CategoryModel.fromMap(map);
      categModelList.add(category);
      notifyListeners();
    }
  }

  CategoryModel getCategoryListItem(int catIndex) {
    return categModelList[catIndex];
  }


  int get CategoryCount => categModelList.length;
  
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

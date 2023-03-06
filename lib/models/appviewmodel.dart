import 'package:flutter/material.dart';
import 'package:todoapp/models/taskmodel.dart';
import 'package:todoapp/models/usermodel.dart';

class AppViewModel extends ChangeNotifier {
  List<Task> taskList = <Task>[];
  User user = User('Greta');

  int get taskCount => taskList.length;

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
}

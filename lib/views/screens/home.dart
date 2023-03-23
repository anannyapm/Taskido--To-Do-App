import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';

import 'package:todoapp/views/screens/profilehome.dart';
import 'package:todoapp/views/screens/taskdetails.dart';
import 'package:todoapp/views/widgets/bottomnavigationwidget.dart';

import '../widgets/bottomsheets/categorysheet.dart';
import '../widgets/bottomsheets/tasksheet.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});
  //static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final isDialOpen = ValueNotifier(false);

  final _pages = [const ScreenProfileHome(), const ScreenTasks()];

  @override
  void initState() {
    // TODO: implement initState
    initdb();

    super.initState();
  }

  void initdb() async {
    await CategRepository.database;
    await TaskRepository.database;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
      
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false ,
            bottomNavigationBar: const BottomNavWidget(),
            
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  return _pages[viewModel.selectedIndexNotifier];
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: SpeedDial(
              elevation: 8,
              icon: Icons.add,
              activeIcon: Icons.close,
              openCloseDial: isDialOpen,
              backgroundColor: const Color(0xff011638),
              children: [
                SpeedDialChild(
                    backgroundColor: const Color(0xff011638),
                    onTap: () async {
                      await viewModel.addToCategList();
                      if (viewModel.categoryCount == 0) {
                        var snackBar = const SnackBar(
                          content: Text(
                            'Oops!Please add a category to start adding tasks!!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 5),
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        viewModel.bottomSheetBuilder(
                            TaskSheetWidget(), context);
                      }
                    },
                    child: const Icon(
                      Icons.add_task,
                      color: Colors.white,
                    ),
                    label: 'Add Tasks'),
                SpeedDialChild(
                    backgroundColor: const Color(0xff011638),
                    onTap: () {
                      viewModel.bottomSheetBuilder(
                          const CategorySheetWidget(), context);
                    },
                    child: const Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    label: 'Add Category'),
              ],
            )),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colorconstants.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';

import 'package:todoapp/views/screens/profilehome.dart';
import 'package:todoapp/views/screens/taskdetails.dart';
import 'package:todoapp/views/widgets/bottomnavigationwidget.dart';
import 'package:todoapp/views/widgets/snackbar.dart';

import '../widgets/bottomsheets/categorysheet.dart';
import '../widgets/bottomsheets/tasksheet.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});
 
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final isDialOpen = ValueNotifier(false);

  final _pages = [const ScreenProfileHome(), const ScreenTasks()];

  @override
  void initState() {
  
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
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: const BottomNavWidget(),
              body: Builder(
                builder: (context) {
                  return _pages[viewModel.selectedIndexNotifier];
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: SpeedDial(
                elevation: 8,
                icon: Icons.add,
                activeIcon: Icons.close,
                openCloseDial: isDialOpen,
                backgroundColor: primaryclr1,
                children: [
                  SpeedDialChild(
                      backgroundColor: primaryclr1,
                      onTap: () {
                        viewModel.bottomSheetBuilder(
                            const CategorySheetWidget(), context);
                      },
                      child: Icon(
                        Icons.category,
                        color: primaryclr4,
                      ),
                      label: 'Add Category'),
                  SpeedDialChild(
                      backgroundColor: primaryclr1,
                      onTap: () {
                        //await viewModel.addToCategList();
                        if (viewModel.categoryCount == 0) {
                          snackBarWidget(
                              context,
                              'Oops!Please add a category to start adding tasks!!',
                             dangerColor);
                          
                        } else {
                          viewModel.bottomSheetBuilder(
                              const TaskSheetWidget(), context);
                        }
                      },
                      child: Icon(
                        Icons.add_task,
                        color: primaryclr4,
                      ),
                      label: 'Add Tasks'),
                  
                ],
              )),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';

import 'package:todoapp/views/screens/profilehome.dart';
import 'package:todoapp/views/screens/taskdetails.dart';
import 'package:todoapp/views/widgets/bottomnavigationwidget.dart';

import '../widgets/bottomsheets/categorysheet.dart';
import '../widgets/bottomsheets/tasksheet.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final isDialOpen = ValueNotifier(false);
  final _pages = [const ScreenProfileHome(), const ScreenTasks()];

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
            bottomNavigationBar: const BottomNavWidget(),
            body: SafeArea(
              child: ValueListenableBuilder(
                valueListenable: ScreenHome.selectedIndexNotifier,
                builder: (context, updatedIndex, _) {
                  return _pages[updatedIndex];
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
              //animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    backgroundColor: const Color(0xff011638),
                    onTap: () {
                      viewModel.bottomSheetBuilder(
                          const TaskSheetWidget(), context);
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

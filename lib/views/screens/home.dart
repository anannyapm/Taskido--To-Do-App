import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:todoapp/views/screens/profilehome.dart';
import 'package:todoapp/views/screens/taskdetails.dart';
import 'package:todoapp/views/widgets/bottomnavigationwidget.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final isDialOpen = ValueNotifier(false);
  final _pages = [ScreenProfileHome(), ScreenTasks()];

  @override
  Widget build(BuildContext context) {
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
          bottomNavigationBar: BottomNavWidget(),
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
            icon: Icons.add,
            activeIcon: Icons.close,
            openCloseDial: isDialOpen,
            backgroundColor: Color(0xff011638),
            //animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                  backgroundColor: Color(0xff011638),
                  onTap: () {},
                  child: Icon(
                    Icons.add_task,
                    color: Colors.white,
                  ),
                  label: 'Add Tasks'),
              SpeedDialChild(
                  backgroundColor: Color(0xff011638),
                  onTap: () {},
                  child: Icon(
                    Icons.category,
                    color: Colors.white,
                  ),
                  label: 'Add Category'),
            ],
          )),
    );
  }
}

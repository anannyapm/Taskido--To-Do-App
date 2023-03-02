import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/bottomnavigationwidget.dart';
import '../widgets/drawerwidget.dart';
import '../widgets/homewidgets/progressindicator.dart';
import '../widgets/homewidgets/streakbar.dart';
import '../widgets/homewidgets/toppannel.dart';

final GlobalKey<ScaffoldState> drawerkey = GlobalKey();

class ScreenProfileHome extends StatefulWidget {
   ScreenProfileHome({super.key});

  @override
  State<ScreenProfileHome> createState() => _ScreenProfileHomeState();
}

class _ScreenProfileHomeState extends State<ScreenProfileHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  scale: 0.8,
                  alignment: Alignment(0.95, -1.0),
                  image: AssetImage('assets/images/home_lineart.png'),
                )),
            child: Scaffold(
              key: drawerkey,
              backgroundColor: Colors.transparent,
              endDrawer: const DrawerWidget(),
              
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  TopPanelWidget(),
                  StreakBarWidget(),
                  ProgressIndicatorWidget(progressVal: 56),
                ],
              )),
            )));
  }
}
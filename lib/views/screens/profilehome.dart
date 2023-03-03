import 'package:flutter/material.dart';

import '../widgets/drawerwidget.dart';
import '../widgets/homewidgets/categoryviewlist.dart';
import '../widgets/homewidgets/progressindicator.dart';
import '../widgets/homewidgets/streakbar.dart';
import '../widgets/homewidgets/toppannel.dart';

final GlobalKey<ScaffoldState> drawerkey = GlobalKey();

class ScreenProfileHome extends StatefulWidget {
  const ScreenProfileHome({super.key});

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
                    const TopPanelWidget(),
                    const StreakBarWidget(),
                    const ProgressIndicatorWidget(progressVal: 56),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: const Text(
                          'My Tasks',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                      ),
                    ),
                    const CategoryViewWidget(),
                  ],
                ),
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../dbfunctions/categorydbrepo.dart';
import '../../viewmodel/appviewmodel.dart';
import '../../models/categorymodel.dart';
import '../widgets/drawerwidget.dart';
import '../widgets/homewidgets/categoryviewlist.dart';
import '../widgets/homewidgets/progressindicator.dart';
import '../widgets/homewidgets/streakbar.dart';
import '../widgets/homewidgets/toppannel.dart';
import '../widgets/homewidgets/upcomingtaskscard.dart';

final GlobalKey<ScaffoldState> drawerkey = GlobalKey();

class ScreenProfileHome extends StatefulWidget {
  const ScreenProfileHome({super.key});

  @override
  State<ScreenProfileHome> createState() => _ScreenProfileHomeState();
}

class _ScreenProfileHomeState extends State<ScreenProfileHome> {
  List<CategoryModel> categList = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
         statusBarColor: Color.fromARGB(255, 255, 255, 255),
         statusBarIconBrightness: Brightness.dark,
      
      )
    );
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return SafeArea(
          child: Container(
             /*  decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    scale: 0.8,
                    alignment: Alignment(0.99, -1.0),
                    image: AssetImage('assets/images/home_lineart.png'),
                  )) */
              child: Scaffold(
                key: drawerkey,
                backgroundColor: Colors.transparent,
                endDrawer: const DrawerWidget(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TopPanelWidget(),
                      const StreakBarWidget(),
                      const ProgressIndicatorWidget(),
                      const UpcomingTasksCard(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, top: 15),
                          child: const Text(
                            'My Categories',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                      ),
                      viewModel.categoryCount == 0
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              /* decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255)) */
                              child: Column(children: [
                                const Text(
                                  'Add a category to start',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:
                                          Color(0xff011638)),
                                ),
                                Image.asset(
                                  'assets/images/empty.png',
                                  scale: 4,
                                ),
                              ]),
                            )
                          : const CategoryViewWidget(),
                          
                    ],
                    
                  ),
                  
                ),
              )));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dbfunctions/categorydbrepo.dart';
import '../../models/appviewmodel.dart';
import '../../models/categorymodel.dart';
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
  List<CategoryModel> categList = <CategoryModel>[];
  /* Future<Future<List<CategoryModel>>> _refreshProducts(BuildContext context) async {
    return CategRepository.getAllData();
  } */

  @override
  void initState() {
    // TODO: implement initState
    /* AppViewModel instance = AppViewModel();
    instance.addCategList(); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
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
                  //physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const TopPanelWidget(),
                      const StreakBarWidget(),
                      ProgressIndicatorWidget(
                        progressVal: viewModel.completedCount.toDouble(),
                        maxVal: viewModel.taskCount.toDouble(),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, top: 15),
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
    });
  }

/*   void addCategoryList() async {
    await CategRepository.getAllData().then((value) {
      setState(() {
        for (var map in value) {
          debugPrint(map.toString());

          categList.add(map);
        }
      });
    }).catchError((e) => debugPrint(e.toString()));
  } */
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_bloc.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_event.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_state.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import '../../data/models/categorymodel.dart';
import '../bloc/taskbloc/task_bloc.dart';
import '../bloc/taskbloc/task_event.dart';
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
    BlocProvider.of<CategoryBloc>(context).add(LoadCategoryEvent());
    BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryclr4,
      statusBarIconBrightness: Brightness.dark,
    ));
    // return Consumer<AppViewModel>(builder: (context, viewModel, child) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: _onWillPop,
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
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: const Text(
                    'My Categories',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                //  print("in profile + $state");
                  if (state is CategCreateState) {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(LoadCategoryEvent());
                  }
                  if (state is CategLoadingState) {
                    if (state.categCount == 0) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Text(
                            'Add a category to start',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: primaryclr1),
                          ),
                          Image.asset(
                            'assets/images/empty.png',
                            scale: 4,
                          ),
                        ]),
                      );
                    } else {
                      return const CategoryViewWidget();
                    }
                  } else if (state is CategErrorState) {
                    return const Text("Error");
                  } else {
                    return const Column(
                      children: [
                        Text("cat loading"),
                        CircularProgressIndicator()
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
    //});
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure? Do you want to exit App?'),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: primaryclr3, fontSize: 16),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "NO",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("YES",
                    style: TextStyle(
                        color: dangerColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        )) ??
        false;
  }
}

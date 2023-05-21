import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/data/repositories/categoryfunctions.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_bloc.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_event.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_state.dart';

import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/taskdbrepo.dart';

import 'package:todoapp/features/presentation/pages/profilehome.dart';
import 'package:todoapp/features/presentation/pages/taskdetails.dart';
import 'package:todoapp/features/presentation/widgets/bottomnavigationwidget.dart';
import 'package:todoapp/features/presentation/widgets/snackbar.dart';

import '../widgets/bottomsheetbuilder.dart';
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
          body: BlocBuilder<PageNavBloc, PageNavState>(
            builder: (context, state) {
             
                return Builder(
                builder: (context) {
                  return _pages[state.selectedIndexNotifier];
                },
              );
              
             
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: //BlocListener<CategoryBloc, CategoryState>(
              /* listener: (context, state) {
                  if (state is CategLoadingState) {
                    if (state.categCount == 0) {
                      snackBarWidget(
                          context,
                          'Oops!Please add a category to start adding tasks!!',
                          dangerColor);
                    } else {
                      viewModel.bottomSheetBuilder(
                          const TaskSheetWidget(), context);
                    }
                  }
                }, */
              //child:
              SpeedDial(
            elevation: 8,
            icon: Icons.add,
            activeIcon: Icons.close,
            openCloseDial: isDialOpen,
            backgroundColor: primaryclr1,
            children: [
              SpeedDialChild(
                  backgroundColor: primaryclr1,
                  onTap: () {
                    bottomSheetBuilder(const CategorySheetWidget(), context);
                  },
                  child: Icon(
                    Icons.category,
                    color: primaryclr4,
                  ),
                  label: 'Add Category'),
              SpeedDialChild(
                  backgroundColor: primaryclr1,
                  onTap: () {
                    /*  BlocProvider.of<CategoryBloc>(context)
                              .add(LoadCategoryEvent()); */
                    //await viewModel.addToCategList();
                    if (CategoryFunctionRepo.categoryCount == 0) {
                      snackBarWidget(
                          context,
                          'Oops!Please add a category to start adding tasks!!',
                          dangerColor);
                    } else {
                      bottomSheetBuilder(const TaskSheetWidget(), context);
                    }
                  },
                  child: Icon(
                    Icons.add_task,
                    color: primaryclr4,
                  ),
                  label: 'Add Tasks'),
            ],
          ),
          //  )
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/features/data/repositories/taskfunctions.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_state.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';
import 'package:todoapp/features/data/models/categorymodel.dart';

import '../../bloc/categorybloc/category_bloc.dart';
import '../../bloc/categorybloc/category_event.dart';
import '../../constants/iconlist.dart';

import '../popupdialogue.dart';
import 'categorygraph.dart';

class CategoryViewWidget extends StatefulWidget {
  const CategoryViewWidget({super.key});

  @override
  State<CategoryViewWidget> createState() => _CategoryViewWidgetState();
}

class _CategoryViewWidgetState extends State<CategoryViewWidget> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppViewModel>(builder: (context, viewModel, child) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        print(state);

        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: FutureBuilder(
              future: CategRepository.getAllData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      CategoryModel catItem = snapshot.data![index];
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5)),
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0x39D0D0D0),
                            Color(0x57E3E2E2)
                          ])),
                          child: ListTile(
                              minLeadingWidth: 25,
                              leading: IconList
                                  .iconValueList[catItem.category_logo_value],
                              title: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((ctx) => CategoryGraph(
                                            totalTodayCount: TaskFunctionRepo
                                                .todayTotalTasks(catItem.cid!),
                                            categoryName: catItem.category_name,
                                            pendingTodayCount: TaskFunctionRepo
                                                .pendingTodayCount(
                                                    catItem.cid!),
                                            completedCount: TaskFunctionRepo
                                                .cBasedCompletdTaskCount(
                                                    catItem.cid!),
                                            totalCount: TaskFunctionRepo
                                                .cBasedTaskCount(catItem.cid!),
                                          ))));
                                },
                                child: Text(
                                  catItem.category_name.toTitleCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  BlocBuilder<TaskBloc, TaskState>(
                                    builder: (context, state) {
                                      return Text(
                                          '${TaskFunctionRepo.cBasedTaskCount(catItem.cid!) - TaskFunctionRepo.cBasedCompletdTaskCount(catItem.cid!)} Tasks');
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        popupDialogueBox(() async {
                                          await deleteCategory(
                                              catItem.category_name, context);
                                          BlocProvider.of<CategoryBloc>(context)
                                              .add(LoadCategoryEvent());
                                          //await viewModel.addToCategList();
                                          //await viewModel.addToTaskList();
                                          BlocProvider.of<TaskBloc>(context)
                                              .add(LoadTaskEvent());
                                        }, context,
                                            'Do you want to delete \'${catItem.category_name.toTitleCase()}\' category?\n\nWarning! All Tasks Will be LOST!');
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: dangerColor,
                                      )),
                                ],
                              )),
                        ),
                      );
                    }),
                    itemCount: snapshot.data?.length,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        );
      },
    );
    //});
  }

  Future<void> deleteCategory(String categoryname, BuildContext ctx) async {
    CategRepository.deleteData(categoryname).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Deleted Category',
          style: TextStyle(color: primaryclr4),
        ),
        backgroundColor: dangerColor,
        padding: const EdgeInsets.all(20),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

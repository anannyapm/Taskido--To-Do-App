import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/views/widgets/homewidgets/categorygraph.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

import '../../../constants/iconlist.dart';
import '../../../viewmodel/appviewmodel.dart';

class CategoryViewWidget extends StatefulWidget {
  const CategoryViewWidget({super.key});

  @override
  State<CategoryViewWidget> createState() => _CategoryViewWidgetState();
}

class _CategoryViewWidgetState extends State<CategoryViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
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
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(57, 208, 208, 208),
                          Color.fromARGB(88, 227, 226, 226)
                        ])),
                        child: ListTile(
                            minLeadingWidth: 25,
                            leading: IconList.iconValueList[
                                catItem.category_logo_value],
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((ctx) => CategoryGraph(
                                      totalTodayCount: viewModel.todayTotalTasks(catItem.cid!),
                                        categoryName: catItem.category_name,
                                        pendingTodayCount: viewModel.pendingTodayCount(catItem.cid!),
                                        completedCount: viewModel.cBasedCompletdTaskCount(catItem.cid!),
                                        totalCount:viewModel.cBasedTaskCount(catItem.cid!) ,
                                                ))));
                              },
                              child: Text(
                                catItem.category_name
                                    .toTitleCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                            trailing: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                    '${viewModel.cBasedTaskCount(catItem.cid!) - viewModel.cBasedCompletdTaskCount(catItem.cid!)} Tasks'),
                                IconButton(
                                    onPressed: () {
                                      popupDialogueBox(() async {
                                        debugPrint("Delete Pressed");
                                        await deleteCategory(
                                            catItem.category_name,
                                            context);
                                        await viewModel.addToCategList();
                                        await viewModel.addToTaskList();
                                      }, context,
                                          'Do you want to delete \'${catItem.category_name.toTitleCase()}\' category?\n\nWarning! All Tasks Will be LOST!');
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
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
    });
  }

  Future<void> deleteCategory(String categoryname, BuildContext ctx) async {
    CategRepository.deleteData(categoryname).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Deleted Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

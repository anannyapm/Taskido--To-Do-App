import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/models/categorymodel.dart';
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
        color: Colors.white,
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
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.5)),
                      child: ListTile(
                          minLeadingWidth: 25,
                          leading: IconList.iconValueList[
                              snapshot.data![index].category_logo_value],
                          title: Text(
                            snapshot.data![index].category_name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                  '${viewModel.cBasedTaskCount(snapshot.data![index].cid!) - viewModel.cBasedCompletdTaskCount(snapshot.data![index].cid!)} Tasks'),
                              IconButton(
                                  onPressed: () {
                                    popupDialogueBox(() async {
                                      debugPrint("Delete Pressed");
                                      await deleteCategory(
                                          snapshot.data![index].category_name,
                                          context);
                                      await viewModel.addToCategList();
                                      await viewModel.addToTaskList();
                                    }, context,
                                        'Do you want to delete ${snapshot.data![index].category_name} category?');
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          )),
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

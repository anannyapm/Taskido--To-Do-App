import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

import '../../../constants/iconlist.dart';
import '../../../models/appviewmodel.dart';
import '../../../models/categoryclass.dart';

class CategoryViewWidget extends StatefulWidget {
  const CategoryViewWidget({super.key});

  @override
  State<CategoryViewWidget> createState() => _CategoryViewWidgetState();
}

class _CategoryViewWidgetState extends State<CategoryViewWidget> {
  @override
  void initState() {
    // TODO: implement initState

    

    super.initState();
  }
  /* Future<Future<List<CategoryModel>>> _refreshProducts(BuildContext context) async {
    return CategRepository.getAllData();
  } */

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      //debugPrint('HI');

      return Container(
        color: Colors.white,
        //height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: FutureBuilder(
            future: CategRepository.getAllData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  //physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    //CategoryModel categItem =
                    //viewModel.getCategoryListItem(index);

                    debugPrint("In listview");
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.5)),
                      child: ListTile(
                          minLeadingWidth: 25,
                          leading: IconList.Iconlist[
                              snapshot.data![index].category_logo_value],
                          title: Text(
                            snapshot.data![index].category_name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              //placeholder 000 given
                              Text('000 Tasks'),
                              IconButton(
                                  onPressed: () {
                                    popupDialogueBox(() {
                                      debugPrint("delete pressed");
                                      deleteCategory(
                                          snapshot.data![index].category_name,
                                          context);
                                      viewModel.addCategList();
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
                return Center(child: CircularProgressIndicator());
              }
            }),
      );
    });
  }

  Future<void> deleteCategory(String categoryname, BuildContext ctx) async {
    /* dynamic out = await CategRepository.deleteData(categoryname);

    debugPrint(out.toString()); */

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

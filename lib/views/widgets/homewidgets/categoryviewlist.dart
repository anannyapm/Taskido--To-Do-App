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
  Widget build(BuildContext context) {
    CategRepository.getAllData();
    
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        color: Colors.white,
        //height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: ((context, index) {
            //CategoryModel categItem = viewModel.getCategoryListItem(index);
            //debugPrint("In listview$categItem");
            return Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5)),
              child: ListTile(
                  minLeadingWidth: 25,
                  leading: IconList.Iconlist[viewModel.getCategoryListItem(index).category_logo_value],
                  title: Text(
                    viewModel.getCategoryListItem(index).category_name,
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
                            popupDialogueBox(() {}, context,
                                'Do you want to delete ${viewModel.getCategoryListItem(index).category_name} category?');
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  )),
            );
          }),
          itemCount: viewModel.CategoryCount,
        ),
      );
    });
  }
}

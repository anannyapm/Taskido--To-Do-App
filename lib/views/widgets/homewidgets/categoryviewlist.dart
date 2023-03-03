import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../../models/categoryclass.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /* List<CategoryClass> categoryList = [
      CategoryClass(
          taskName: 'Personal',
          taskIcon: Icon(FontAwesome.heart,color: Color(0xffF96900),size: 25,),
          taskLiveCount: 6,
          taskTotalCount: 10),
      CategoryClass(
          taskName: 'Work',
          taskIcon: Icon(FontAwesome.suitcase,color: Color(0xff66635B),size: 25),
          taskLiveCount: 8,
          taskTotalCount: 10),
      
      CategoryClass(
          taskName: 'Movies to Watch',
          taskIcon: Icon(FontAwesome5.film,color: Color(0xff00A9A5),size: 25),
          taskLiveCount: 0,
          taskTotalCount: 10),
    ]; */

    return Container(
      color: Colors.white,
      //height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: ListView.builder(

        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: ((context, index) {
          return Card(
            elevation: 6,
            margin: EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
            child: ListTile(
              minLeadingWidth:25 ,
              leading: categoryList[index].taskIcon,
              title: Text(categoryList[index].taskName,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
              trailing:Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                    Text(categoryList[index].taskLiveCount.toString()+' Tasks'),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.red,)),
                ],
              )
                  
            ),
          );
        }),
        itemCount: categoryList.length,
      ),
    );
  }
}

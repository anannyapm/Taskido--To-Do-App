

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/repository.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';

import '../../../../viewmodel/appviewmodel.dart';
import '../../pages/profilehome.dart';


class TopPanelWidget extends StatefulWidget {
  const TopPanelWidget({super.key});

  @override
  State<TopPanelWidget> createState() => _TopPanelWidgetState();
}

class _TopPanelWidgetState extends State<TopPanelWidget> {
  @override
  Widget build(BuildContext context) {
    

      return Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  
                  margin: const EdgeInsets.all(15),
                  child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: primaryclr4,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Repository.currentUserPhoto),
                                      fit: BoxFit.cover)),
                            )
                         ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Hey!',
                      style: TextStyle(
                        fontSize: 18,
                        //height: 0.5,
                        fontWeight: FontWeight.w400,
                        color: primaryclr1,
                      ),
                    ),
                    Text(
                      Repository.currentUserName.toTitleCase(),
                      style:  TextStyle(
                        fontSize: 28,
                        height: 1.1,
                        fontWeight: FontWeight.w600,
                        color: primaryclr1,
                      ),
                    ),
                  ],
                ),
                //),
              ],
            ),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      drawerkey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    )))
          ],
        ),
      );
 
  }
}

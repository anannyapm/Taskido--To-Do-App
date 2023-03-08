import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/functions/string_extensions.dart';

import '../../../models/appviewmodel.dart';
import '../../screens/profilehome.dart';

class TopPanelWidget extends StatefulWidget {
  const TopPanelWidget({super.key});

  @override
  State<TopPanelWidget> createState() => _TopPanelWidgetState();
}

class _TopPanelWidgetState extends State<TopPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
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
                      child: viewModel.profilePhoto?.path == null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Repository.currentUserPhoto),
                                      fit: BoxFit.cover)),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(Repository.currentUserPhoto)),
                                      fit: BoxFit.cover)),
                            )),
                ),
                Column(
                  //text: const TextSpan(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Hey!',
                      style: TextStyle(
                        fontSize: 18,
                        //height: 0.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff011638),
                      ),
                    ),
                     Text(
                      Repository.currentUserName.toTitleCase(),
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.1,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff011638),
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
    });
  }
}

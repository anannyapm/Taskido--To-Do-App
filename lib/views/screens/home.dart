import 'package:flutter/material.dart';
import 'package:todoapp/views/widgets/drawerwidget.dart';
import 'package:todoapp/views/widgets/homewidgets/progressindicator.dart';
import 'package:todoapp/views/widgets/homewidgets/toppannel.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

final GlobalKey<ScaffoldState> drawerkey = GlobalKey();

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  alignment: Alignment(0.7, -1.0),
                  image: AssetImage('assets/images/home_lineart.png'),
                )),
            child: Scaffold(
              key: drawerkey,
              backgroundColor: Colors.transparent,
              endDrawer: const DrawerWidget(),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                   TopPanelWidget(),
                   
                  Align(
                    alignment: const Alignment(-1, 1),
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Color(0xff011638)),
                      child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          
                          children: [
                            const Text(
                              'You are on Streak',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xffFFFFFF), Color(0xffFF1F00)],
                                  ).createShader(bounds);
                                },
                                child: const Icon(
                                  FontAwesome5.fire,
                                  color: Colors.white,
                                  size: 25,
                                  
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                ProgressIndicatorWidget(),
               
                  
                ],
              )),
            )));
  }
}

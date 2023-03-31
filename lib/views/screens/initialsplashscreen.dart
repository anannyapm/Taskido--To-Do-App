import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/splashscreen.dart';
import '../../constants/colorconstants.dart';
import '../../dbfunctions/categorydbrepo.dart';
import '../../dbfunctions/repository.dart';
import '../../dbfunctions/taskdbrepo.dart';
import '../../main.dart';

class ScreenInitialSplash extends StatefulWidget {
  const ScreenInitialSplash({super.key});

  @override
  State<ScreenInitialSplash> createState() => _ScreenInitialSplashState();
}

class _ScreenInitialSplashState extends State<ScreenInitialSplash> {
  @override
  void initState() {
    initdb();
    checkUserLogin();

    super.initState();
  }

  void initdb() async {
    await Repository.database;
    await CategRepository.database;
    await TaskRepository.database;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryclr3),
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          body: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: Center(
                      child: SizedBox(
                    child: DefaultTextStyle(
                      style:  TextStyle(
                        fontSize: 50.0,
                        
                        color: primaryclr4,
                          fontWeight: FontWeight.w500
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                  'Taskido',
                                  curve: Curves.easeIn,
                                  speed: const Duration(milliseconds: 220)),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                      )))),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const ScreenSplash()));
  }

  Future<void> checkUserLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getString(SAVE_KEY_NAME);

    if (userLoggedIn == null) {
      gotoLogin();
    } else {
      List<Map<String, dynamic>> out = await Repository.fetchData(userLoggedIn);
      Map val = out[0];
    
      await Repository.setCurrentUser(
          val['uid'], val['name'], val['email'], val['photo']);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<AppViewModel>(context, listen: false).addToCategList();
        Provider.of<AppViewModel>(context, listen: false).addToTaskList();
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx1) => const ScreenHome()),(route)=>false);
    }
  }
}

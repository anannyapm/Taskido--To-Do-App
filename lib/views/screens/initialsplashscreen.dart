import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/splashscreen.dart';

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
    // TODO: implement initState
    checkUserLogin();
    initdb();
    

    super.initState();
  }

  void initdb() async {
    await CategRepository.database;
    await TaskRepository.database;
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      Provider.of<AppViewModel>(context, listen: false).addCategList();
      Provider.of<AppViewModel>(context, listen: false).addTaskList();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      "To Do App",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 25),
                    ),
                  )))),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => ScreenSplash()));
  }

  Future<void> checkUserLogin() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getString(SAVE_KEY_NAME);
    //if not logged in ie launching app first time - then null
    //if logged out -false
    if (_userLoggedIn == null) {
      gotoLogin();
    } else {
      List<Map<String, dynamic>> out =
          await Repository.fetchData(_userLoggedIn);
      Map val = out[0];
      debugPrint(out.toString());
      await Repository.setCurrentUser(
          val['uid'], val['name'], val['email'], val['photo']);

      //_userLoggedIn becomes true, so go to home page
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
    }
  }
}

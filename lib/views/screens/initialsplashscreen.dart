import 'package:flutter/material.dart';
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          body: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: const Center(
                    child: Text(
                      "Taskido App",
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
      debugPrint("Checking User Login - User Fetch Output - ${out.toString()}");
      await Repository.setCurrentUser(
          val['uid'], val['name'], val['email'], val['photo']);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<AppViewModel>(context, listen: false).addToCategList();
        Provider.of<AppViewModel>(context, listen: false).addToTaskList();
      });

      //_userLoggedIn becomes true, so go to home page
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ScreenHome()));
    }
  }
}

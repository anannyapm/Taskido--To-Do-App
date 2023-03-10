import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/login.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/views/screens/profilehome.dart';
import 'package:todoapp/views/screens/signup.dart';
import 'package:todoapp/views/screens/splashscreen.dart';
import 'package:todoapp/views/screens/taskdetails.dart';


const SAVE_KEY_NAME = 'UserLoggedIn'; //value of shared prefrence stored here ;ie it can be true or false for this key

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'onboardingScreen',
  
  routes: {  
    'onboardingScreen':(context)=>OnboardingHome(),
    // When navigating to the "homeScreen" route, build the HomeScreen widget.
    'homeScreen': (context) => ScreenHome(),
    // When navigating to the "secondScreen" route, build the SecondScreen widget.
    'loginScreen': (context) => ScreenLogin(),
    'signupScreen':(context) => ScreenSignUp(),
    'profileScreen':(context) => ScreenProfileHome(),
    'taskScreen':(context) => ScreenTasks(),
  },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const ScreenSplash(),
    );
  }
}

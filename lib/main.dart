import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/screens/initialsplashscreen.dart';


const SAVE_KEY_NAME = 'UserLoggedIn'; //value of shared prefrence stored here 
const SAVE_KEY_PROFILE = 'UserProfileImage'; //value of shared prefrence stored here 

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const ScreenInitialSplash(),
    );
  }
}







//For Reference
//Using routes
   /* initialRoute: 'onboardingScreen',
  
  routes: {  
    'onboardingScreen':(context)=>OnboardingHome(),
    // When navigating to the "homeScreen" route, build the HomeScreen widget.
    'homeScreen': (context) => ScreenHome(),
    // When navigating to the "secondScreen" route, build the SecondScreen widget.
    'loginScreen': (context) => ScreenLogin(),
    'signupScreen':(context) => ScreenSignUp(),
    'profileScreen':(context) => ScreenProfileHome(),
    'taskScreen':(context) => ScreenTasks(),
  }, */
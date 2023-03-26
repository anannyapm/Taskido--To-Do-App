import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';
import 'package:todoapp/views/widgets/gradienttext.dart';

import '../../constants/colorconstants.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
         statusBarColor: primaryclr4,
         statusBarIconBrightness: Brightness.dark,
         
      )
    );
    return SafeArea(
      //set background
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration:  BoxDecoration(
              color: primaryclr4,),

        //Scaffold area
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Align(
                  child: Container(
                    transform: Matrix4.rotationZ(6.9),
                    transformAlignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height) * 0.4,
                    child: Image.asset(
                      'assets/images/clock.png',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children:  [
                    const GradientTextWidget(
                      textValue: 'Taskido App',
                      textSize: 34,
                      weight: FontWeight.w700,
                    ),
                    Text(
                      'Get your tasks done!',
                      style: TextStyle(
                          color: primaryclr1, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                    child: GradientBox(
                  colorStart:  primaryclr1,
                  colorEnd: primaryclr2,
                  gradFunction: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const OnboardingHome()),(route)=>false),
                      /* MaterialPageRoute(
                          builder: (context) => const OnboardingHome()) */
                  textVal: "Let's Start",
                  textColor: primaryclr4,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

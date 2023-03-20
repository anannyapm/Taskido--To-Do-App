import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';
import 'package:todoapp/views/widgets/gradienttext.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //set background
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
              color: Colors.white,),

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
                  children: const [
                    GradientTextWidget(
                      textValue: 'To Do App',
                      textSize: 34,
                      weight: FontWeight.w700,
                    ),
                    Text(
                      'Get your tasks done!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 1, 22, 56), fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                    child: GradientBox(
                  colorStart: const Color(0xff011638),
                  colorEnd: const Color(0xff00A9A5),
                  gradFunction: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const OnboardingHome())),
                  textVal: "Let's Start",
                  textColor: Colors.white,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/lineart.png'), scale:2,fit: BoxFit.cover)),

        //Scaffold area
        child: Scaffold(
          backgroundColor: Colors.transparent,

          //creating stack to bring elements in a positioned manner
          //over a container occupying screen size

          body: Stack(
            children: [
              //Parent container
              Container(
                width: double.infinity,
              ),

              //Clock image container
              Container(
                transform: Matrix4.rotationZ(6.9),
                transformAlignment: Alignment.center,
                margin: const EdgeInsets.only(top: 60, left: 5),
                height: 350,
                width: 350,
                child: Image.asset(
                  'assets/images/clock.png',
                ),
              ),

              //To Do App logo and subtitle
              //using custom widget gradienttext widget to give text gradient.
              Positioned(
                  bottom: 140,
                  left: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientTextWidget(
                        textValue: 'To Do App',
                        textSize: 34,
                        weight: FontWeight.w700,
                      ),
                      const Text(
                        'Get your tasks done!',
                        style: TextStyle(
                            color: Color.fromARGB(255, 1, 22, 56),
                            fontSize: 20),
                      ),
                    ],
                  )),

              //Button to move to onboarding page

              Positioned(
                bottom: 50,
                left: 0,
                right: 0,

                //align content to center by default and set container to
                // hardcoded width and height and gradient.
                //elevatted button is addded inside the  container to give color gradient to button

                child: Align(
                  child: GradientBox(
                    colorStart:const Color(0xff011638) ,
                    colorEnd: const Color(0xff00A9A5),
                    gradFunction: ()=>Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OnboardingHome())),
                             textVal: "Let's Start",
                    textColor: Colors.white,)
                  
                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

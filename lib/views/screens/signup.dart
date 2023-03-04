import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/login.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';

import '../widgets/loginwidgets/bottombarwidget.dart';
import '../widgets/loginwidgets/headingmessage.dart';
import '../widgets/loginwidgets/textfieldwidget.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  image: AssetImage('assets/images/signbg.png'),
                 )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset:false,
          body: Container(
              
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color.fromARGB(107, 51, 51, 51))),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(
                          /* MaterialPageRoute(
                            builder: (ctx) => const OnboardingHome()) */
                            );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const HeadingMessage(
                          heading: "Hello There!\n",
                          subheading: "Let's get you onboarded.",
                        ),
                    
                        const SizedBox(
                          height: 50,
                        ),
                    
                        Form(
                          key: _formKey,
                    
                          //child: Expanded(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextFieldWidget(
                                hint: "Enter User Name",
                                label: "User Name",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const TextFieldWidget(
                                  hint: "Enter Email Address",
                                  label: "Email Address"),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                child: GradientBox(
                                  colorStart:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  colorEnd:
                                      const Color.fromARGB(255, 4, 209, 206),
                                  gradFunction: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   const ScreenHome()));
                                    } else {
                                     // print('Empty fields found');
                                    }
                                  },
                                  textVal: "Sign Up",
                                  textColor: const Color(0xff011638),
                                ),
                              )
                            ],
                          ),
                        ),
                        //),
                      ],
                    ),
                  ),
                   Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomTextButton(
                        linkText: 'Log In',
                        function: ()=>Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ScreenLogin())),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}

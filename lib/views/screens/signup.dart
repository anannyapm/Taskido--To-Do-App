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
                  alignment: Alignment.topRight,
                  image: AssetImage('assets/images/Vector2.png'),
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
                  
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          const HeadingMessage(
                            heading: "Hello There!\n",
                            subheading: "Let's get you onboarded.",
                          ),
                      
                          const SizedBox(
                            height: 30,
                          ),
                      
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Align(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                             // _photo?.path == null?
                             const CircleAvatar(
                                radius: 35,
                              backgroundColor: Color(0xFF04D1CE),
                              child: CircleAvatar(
                                radius:33,
                                backgroundImage: AssetImage(
                                    'assets/images/stacked-steps-haikei.png'),
                              ),
                                
                              ),
                            /* : CircleAvatar(
                                radius: 50,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: FileImage(
                                  File(
                                    _photo!.path,
                                  ),
                                ),
                              ),
                                
                                
                              ), */
                              Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 255, 255, 255)
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: Color.fromARGB(255, 1, 1, 1)),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit,size: 15,color: Colors.white,),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      //getPhoto();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                        Color(0xFF04D1CE),
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

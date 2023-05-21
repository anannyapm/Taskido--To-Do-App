import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/features/presentation/bloc/userbloc/user_bloc.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_event.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_state.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/features/presentation/pages/home.dart';
import 'package:todoapp/features/presentation/pages/signup.dart';
import 'package:todoapp/features/presentation/widgets/gradientbox.dart';
import 'package:todoapp/features/presentation/widgets/snackbar.dart';

import '../bloc/categorybloc/category_bloc.dart';
import '../bloc/categorybloc/category_event.dart';
import '../constants/colorconstants.dart';

import '../widgets/loginwidgets/bottombarwidget.dart';
import '../widgets/loginwidgets/headingmessage.dart';
import '../widgets/loginwidgets/textfieldwidget.dart';
import 'onboardinghome.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 255, 255),
        statusBarIconBrightness: Brightness.dark,
      ));
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: primaryclr4,
              image: const DecorationImage(
                alignment: Alignment.topRight,
                image: AssetImage('assets/images/Vector2.png'),
                scale: 1.5,
              )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: primaryclr3,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnboardingHome()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: (MediaQuery.of(context).size.height) * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeadingMessage(
                                heading: "Welcome Back!\n",
                                subheading:
                                    "Woo Hoo!\nIt's time to check back in",
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              BlocListener<UserBloc, UserState>(
                                listener: (context, state) async {
                                  if (state is LoginFailure) {
                                    snackBarWidget(context, state.errorMessage,
                                        dangerColor);
                                  } else if (state is LoginSucess) {
                                    BlocProvider.of<CategoryBloc>(
                                                      context)
                                                  .add(LoadCategoryEvent());
                                  //  await viewModel.addToCategList();
                                    await viewModel.addToTaskList();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ScreenHome()));
                                  }
                                },
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFieldWidget(
                                        hint: "Enter Email Address",
                                        label: "Email Address",
                                        textController: _emailController,
                                        typeValue: TextInputType.emailAddress,
                                      ),
                                      Align(
                                        child: GradientBox(
                                          colorStart: primaryclr4,
                                          colorEnd: pClr2Shade1,
                                          gradFunction: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<UserBloc>(context)
                                                  .add(LoginEvent(
                                                      email: _emailController
                                                          .text
                                                          .trim()));

                                            } else {
                                              debugPrint('Empty field found');
                                            }
                                          },
                                          textVal: "Log In",
                                          textColor: primaryclr1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: BottomTextButton(
                                        linkText: 'Sign Up',
                                        function: () => Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ScreenSignUp()),
                                            ))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }


}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/usermodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/login.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/constants/avatars.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';
import '../../constants/colorconstants.dart';
import '../../main.dart';
import '../../viewmodel/appviewmodel.dart';
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
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
        statusBarColor: primaryclr4,
        statusBarIconBrightness: Brightness.dark,
      ));
      return SafeArea(
        child: Container(
          decoration:  BoxDecoration(
              color: primaryclr4,
              image: const DecorationImage(
                alignment: Alignment.topRight,
                image: AssetImage('assets/images/Vector2.png'),
                scale: 1.5,
              )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                height: MediaQuery.of(context).size.height,
                //add height
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: pClr3Shade1)),
                      child: IconButton(
                        icon:  Icon(
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: (MediaQuery.of(context).size.height) * 0.75,
                          margin: const EdgeInsets.only(top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeadingMessage(
                                heading: "Hello There!\n",
                                subheading: "Let's get you onboarded.",
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Align(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      viewModel.profilePhoto == ''
                                          ?  CircleAvatar(
                                              radius: 35,
                                              backgroundColor:pClr3Shade2,
                                              child: const CircleAvatar(
                                                radius: 34,
                                                backgroundImage: AssetImage(
                                                    'assets/images/stacked-steps-haikei.png'),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 35,
                                              backgroundColor:pClr3Shade2,
                                              child: CircleAvatar(
                                                radius: 34,
                                                backgroundColor: primaryclr4,
                                                backgroundImage: AssetImage(
                                                    viewModel.profilePhoto),
                                              ),
                                            ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryclr4),
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          decoration:  BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  primaryclr3),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 15,
                                              color: primaryclr4,
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext ctx) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              'Select your Avatar'),
                                                          TextButton(
                                                              onPressed: () {
                                                                viewModel
                                                                    .setProfile(
                                                                        'assets/images/stacked-steps-haikei.png');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text('Clear')),
                                                        ],
                                                      ),
                                                      content: SizedBox(
                                                        height: MediaQuery.of(context).size.height*0.6,
                                                        width: MediaQuery.of(context).size.width*0.8,
                                                        child: GridView(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const ClampingScrollPhysics(),
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          children:
                                                              List.generate(
                                                                  avatarImages
                                                                      .length,
                                                                  (index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                viewModel.setProfile(
                                                                    avatarImages[
                                                                        index]);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Card(
                                                                child: Image.asset(
                                                                        avatarImages[
                                                                            index]),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    );
                                                  });
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
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      hint: "Enter User Name",
                                      label: "User Name",
                                      textController: _usernameController,
                                    ),
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
                                        gradFunction: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            addUserToModel(
                                                viewModel.profilePhoto,
                                                context);

                                            _usernameController.text = '';
                                            _emailController.text = '';
                                            viewModel.setProfile('');
                                            debugPrint(
                                                'Profile is ${viewModel.profilePhoto}');
                                          } else {
                                            debugPrint('Empty fields found');
                                          }
                                        },
                                        textVal: "Sign Up",
                                        textColor:  primaryclr1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: BottomTextButton(
                                      linkText: 'Log In',
                                      function: () => Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  const ScreenLogin())),
                                    )),
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

  Future<void> addUserToModel(String profilephoto, BuildContext ctx) async {
    final _name = _usernameController.text.trim();
    final _email = _emailController.text.trim();
    String _photo = 'assets/images/stacked-steps-haikei.png';

    final _image = profilephoto;

    if (_image != '') {
      _photo = _image;
    }

    final _userObject = UserModel(name: _name, email: _email, photo: _photo);

    /* print("$_name $_email before calling savedata"); */

    dynamic out = await Repository.saveData(_userObject);
    if (out == true) {
      final List<Map<String, dynamic>> uidFetchOutput =
          await Repository.fetchID(_email);
      final _currentUserId = uidFetchOutput[0]['uid'];
      print(_currentUserId);
      await Repository.setCurrentUser(_currentUserId, _name, _email, _photo);

      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setString(SAVE_KEY_NAME, _email);

      Navigator.of(ctx).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScreenHome()),
          (route) => false);
    } else {
      var snackBar =  SnackBar(
        content: Text(
          'This email id is already registered. Please Login back to continue!',
          style: TextStyle(color: primaryclr4),
        ),
        backgroundColor:dangerColor,
        padding: EdgeInsets.all(20),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
    debugPrint(out.toString());
  }
}

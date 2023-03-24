import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';
import 'package:todoapp/views/screens/privacypolicy.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../dbfunctions/repository.dart';
import '../../viewmodel/appviewmodel.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              margin: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/drawerbg.png'),
                      fit: BoxFit.fill)),
              accountName: SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.3,
                child: Text(
                  Repository.currentUserName.toTitleCase(),
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff011638)),
                ),
              ),
              accountEmail: SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.5,
                child: Text(
                  Repository.currentUserMail,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: Color(0xff011638)),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                
                backgroundColor: Colors.white,
                      backgroundImage: AssetImage(Repository.currentUserPhoto),
                    )
                  
            ),
            ListTile(
              leading: const Icon(
                Icons.share,
              ),
              title: const Text('Share To Do App'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.privacy_tip,
              ),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => PrivacyPolicy())));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.star,
              ),
              title: const Text('Rate Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.mail,
              ),
              title: const Text('Contact Us'),
              onTap: () async {
                String email =
                    Uri.encodeComponent("anannyaanilpm@gmail.com.com");
                String subject = Uri.encodeComponent("Info about To Do App");
                String body = Uri.encodeComponent("Hi There!");
                debugPrint("Mail Subject:$subject");
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
                //Navigator.pop(context);
              },
            ),
            const AboutListTile(
              icon: Icon(
                Icons.info,
              ),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'To Do App',
              applicationVersion: '1.0',
              applicationLegalese: '© Anannya P M',
              aboutBoxChildren: [],
              child: Text('About app'),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: const Text('Sign Out'),
              onTap: () async {
                popupDialogueBox(() async {
                  final _sharedPrefs = await SharedPreferences.getInstance();
                  await _sharedPrefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OnboardingHome()),
                      (route) => false);
                }, context, 'Are you sure you want to Sign Out?');
              },
            ),
          ],
        ),
      );
    });
  }
}

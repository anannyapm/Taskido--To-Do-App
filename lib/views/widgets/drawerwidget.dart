import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';

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
              currentAccountPicture: viewModel.profilePhoto?.path == null
                  ? CircleAvatar(
                      backgroundImage: AssetImage(Repository.currentUserPhoto),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          FileImage(File(Repository.currentUserPhoto)),
                    ),
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
                Navigator.pop(context);
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
              onTap: () {
                Navigator.pop(context);
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
                final _sharedPrefs = await SharedPreferences.getInstance();
                await _sharedPrefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const OnboardingHome()),
                    (route) => false);
              },
            ),
          ],
        ),
      );
    });
  }
}

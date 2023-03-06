import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/onboardinghome.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/drawerbg.png'),
                    fit: BoxFit.fill)),
            accountName: Text(
              "Greta",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff011638)),
            ),
            accountEmail: Text(
              "gretagreg123@gmail.com",
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Color(0xff011638)),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profileImage.jpg'),
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
            // <-- SEE HERE
            icon: Icon(
              Icons.info,
            ),
            applicationIcon: Icon(
              Icons.local_play,
            ),
            applicationName: 'To Do App',
            applicationVersion: '1.0',
            applicationLegalese: '© Anannya P M',
            aboutBoxChildren: [
              ///Content goes here...
            ],
            child: Text('About app'),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
            ),
            title: const Text('Sign Out'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OnboardingHome()));
            },
          ),
        ],
      ),
    );
  }
}

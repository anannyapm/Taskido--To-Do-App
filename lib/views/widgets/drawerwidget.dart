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
           UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/drawerbg.png'),
                    fit: BoxFit.fill)),
            accountName: SizedBox(
              width: (MediaQuery.of(context).size.width)*0.3,
              child: const Text(
                
                "Greta",
              maxLines: 2,
           
                
                style: TextStyle(
                        
                    fontWeight: FontWeight.bold, color: Color(0xff011638)),
              ),
            ),
            accountEmail: SizedBox(
              width: (MediaQuery.of(context).size.width)*0.5,
              child: const Text(
                
                "gretagreg123@gmail.com",
                maxLines: 2,
                style: TextStyle(
                
                    fontWeight: FontWeight.w400, color: Color(0xff011638)),
              ),
            ),
            currentAccountPicture:const CircleAvatar(
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
                  MaterialPageRoute(builder: (context) => const OnboardingHome()));
            },
          ),
        ],
      ),
    );
  }
}

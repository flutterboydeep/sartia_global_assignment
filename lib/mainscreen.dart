import 'package:flutter/material.dart';
import 'package:sartia_global_assignment/tap_drawer_screens/home_screen.dart';
import 'package:sartia_global_assignment/tap_drawer_screens/settings.dart';
import 'package:sartia_global_assignment/utils/textHelper.dart';

import 'tap_drawer_screens/profile_screen.dart';

List<Widget> drawerOnTapScreens = [
  Homepage(),
  ProfileScreen(),
  SettingScreen()
];
List<String> drawerOnTapScreensText = ['Home', 'Profile', 'Settings'];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int drawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            )),
            ListTile(
              selected: drawerIndex == 0 ? true : false,
              leading: Icon(Icons.home),
              onTap: () {
                setState(() {
                  drawerIndex = 0;
                });
                Navigator.maybePop(context);
              },
              title: TextHelper(
                text: drawerOnTapScreensText[0],
                textColor: drawerIndex == 0 ? Colors.deepPurple : Colors.black,
              ),
            ),
            ListTile(
              selected: drawerIndex == 1 ? true : false,
              leading: Icon(Icons.person),
              onTap: () {
                setState(() {
                  drawerIndex = 1;
                });
                Navigator.maybePop(context);
              },
              title: TextHelper(
                text: drawerOnTapScreensText[1],
                textColor: drawerIndex == 1 ? Colors.deepPurple : Colors.black,
              ),
            ),
            ListTile(
              selected: drawerIndex == 2 ? true : false,
              leading: Icon(Icons.person),
              onTap: () {
                setState(() {
                  drawerIndex = 2;
                });
                Navigator.maybePop(context);
              },
              title: TextHelper(
                text: drawerOnTapScreensText[2],
                textColor: drawerIndex == 2 ? Colors.deepPurple : Colors.black,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: TextHelper(text: drawerOnTapScreensText[drawerIndex]),
      ),
      body: drawerOnTapScreens[drawerIndex],
    );
  }
}

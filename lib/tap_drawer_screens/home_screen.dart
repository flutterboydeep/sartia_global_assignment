import 'package:flutter/material.dart';
import 'package:sartia_global_assignment/tap_drawer_screens/profile_screen.dart';
import 'package:sartia_global_assignment/tap_drawer_screens/settings.dart';
import 'package:sartia_global_assignment/tebs/home_tab.dart';
import 'package:sartia_global_assignment/tebs/profile_tab.dart';
import 'package:sartia_global_assignment/tebs/search_tab.dart';
import 'package:sartia_global_assignment/utils/textHelper.dart';

List<Widget> tabScreens = [
  HomeTab(),
  SearchTab(),
  ProfileTab(),
];

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        tabScreens[tabIndex],
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2), label: "Profile"),
            ],
            currentIndex: tabIndex,
            onTap: (value) {
              setState(() {
                tabIndex = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

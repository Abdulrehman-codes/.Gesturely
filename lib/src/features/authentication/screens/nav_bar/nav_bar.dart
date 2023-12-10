import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  List pages = [
    const DashBoard(),
    const LoginScreen(),
    const Welcome(),
  ];

  int currentIndexNavBar = 0;

  void onTapNavBar(int index) {
    if (index >= 0 && index < pages.length) {
      if (index == pages.length - 1) {
        // If the "Logout" button is tapped, show confirmation dialog
      } else {
        setState(() {
          currentIndexNavBar = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pages[currentIndexNavBar],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: currentIndexNavBar,
        onTap: onTapNavBar,
        unselectedFontSize: 0,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: '',
            icon: ClipOval(
              child: Container(
                width: 40,
                height: 40,
                color: Colors.black, // Set background color for the circular button
                child: Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.white, // Set icon color
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.share)),
        ],
      ),
    );
  }
}

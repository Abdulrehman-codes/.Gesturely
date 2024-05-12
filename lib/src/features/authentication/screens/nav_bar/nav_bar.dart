import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/user_managment/user_management.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:fyp/src/features/authentication/screens/camera/camera_screen.dart'; // Import the camera screen

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  List<Widget> pages = [
    const DashBoard(),
    const CameraApp(),
    const UserManagement(),
  ];

  int currentIndexNavBar = 0;

  void onTapNavBar(int index) {
    if (index >= 0 && index < pages.length) {
      setState(() {
        currentIndexNavBar = index;
      });
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
        backgroundColor: Color(0xff9a83e5), // 0xff912BBC
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: IconButton(
              icon: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Color(0xff1C1678),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () => onTapNavBar(0),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Camera',
            icon: IconButton(
              icon: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Color(0xff1C1678),
                  child: const Icon(
                    Icons.camera_enhance_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () => onTapNavBar(1),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Share',
            icon: IconButton(
              icon: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Color(0xff1C1678),
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () => onTapNavBar(2),
            ),
          ),
        ],
      ),
    );
  }
}

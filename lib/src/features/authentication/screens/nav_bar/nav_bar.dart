import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
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
    const LoginScreen(),
    const Welcome(),
    // Add the CameraScreen() here if you want it in the pages list
  ];

  int currentIndexNavBar = 0;

  void onTapNavBar(int index) {
    if (index >= 0 && index < pages.length) {
      if (index == 2) { // Assuming the camera button is the third item
        Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
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
            icon: IconButton(
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen())),
            ),
          ),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.share)),
        ],
      ),
    );
  }
}

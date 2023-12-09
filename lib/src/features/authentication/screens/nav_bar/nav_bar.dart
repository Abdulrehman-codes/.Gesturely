import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class AdminPanelMain extends StatefulWidget {
  const AdminPanelMain({super.key});
  @override
  _AdminPanelMainState createState() => _AdminPanelMainState();
}

class _AdminPanelMainState extends State<AdminPanelMain> {
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
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Camera', icon: Icon(Icons.camera_enhance_sharp)),
          BottomNavigationBarItem(label: 'Share', icon: Icon(Icons.share)),
        ],
      ),
    );
  }
}

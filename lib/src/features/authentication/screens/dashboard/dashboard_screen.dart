import 'dart:ui'; // Import this for the ImageFilter class
import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/library/library.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(gDashboard), // Assuming gDashboard is your background image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xff89fff1).withOpacity(0.2), // Adjust the color and opacity
            BlendMode.dstATop,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0), // Adjust the blur intensity
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(top: 20, child: _buildTop()),
              Positioned(bottom: 0, child: _buildBottom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Handle left button press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () {
                    Get.to(() => const ProfileScreen()); // Handle right button press
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          buildProfileImage(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget buildProfileImage() => const CircleAvatar(
    radius: 70,
    backgroundColor: Colors.grey,
    backgroundImage: AssetImage(gEmptyProfile),
  );

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Profile Name",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "blah blah blah blah blah blah",
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        Container(width: mediaSize.width, height: 3, color: Colors.black),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => const Library()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 30, right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: 50,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.library_books),
                    const SizedBox(height: 8),
                    Text(
                      "Library".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 30, right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: 50,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.library_books),
                    const SizedBox(height: 8),
                    Text(
                      "Cmd".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 30, right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: 50,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.library_books),
                    SizedBox(height: 8),
                    Text(
                      "Custom".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

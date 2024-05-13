import 'dart:ui'; // Import this for the ImageFilter class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_Selection.dart';
import 'package:fyp/src/features/authentication/screens/library/library.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/controllers/profile_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../models/user_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var channel = const MethodChannel("gesturely");
  final controller = Get.put(ProfileController());
  late Size mediaSize;
  File? _image; // Add this line to hold the selected image
  final PageController _pageController = PageController();

  showToast() {
    channel.invokeMethod("showToast");
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
              gDashboard), // Assuming gDashboard is your background image
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  Text("Logout Confirmation",style: Theme.of(context).textTheme.bodyMedium),
                          content:  Text("Are you sure you want to log out?",style: Theme.of(context).textTheme.bodyMedium),
                          actions: <Widget>[
                            // Cancel button
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("Cancel",style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            // Logout button
                            TextButton(
                              onPressed: () {
                                // Perform the logout action
                                AuthenticationRepository.instance.logout();
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child:  Text(gLogout,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
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
        color: Color(0x2FA76DEC),
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

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _imgFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _imgFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image taken.');
    }
  }
  Widget buildProfileImage() => GestureDetector(
    onTap: _showPicker,
    child: CircleAvatar(
      radius: 70,
      backgroundColor: Colors.grey,
      backgroundImage: _image != null
          ? FileImage(_image!)
          : AssetImage(gHand) as ImageProvider<Object>?,
    ),
  );

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        FutureBuilder(
          future: controller.getUserData(), // Assuming getUserData() returns a Future<UserModel>
          builder: (context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                'Hello From Gesturely',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else if (snapshot.hasData) {
              final UserModel user = snapshot.data!;
              return Column(
                children: [
                  Text(
                    user.fullName, // Assuming 'fullName' is a field in UserModel
                    style: TextStyle(
                      color: Color(0xff9a83e5),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia', // Change 'YourFont' to the desired font family
                      //fontStyle: FontStyle.italic, // Change to FontStyle.normal if needed
                      // You can also use other properties like letterSpacing, wordSpacing, etc.
                    ),
                  ),

                ],
              );
            } else {
              return const Text('No data');
            }
          },
        ),
        const SizedBox(height: 30),
        Container(
          height: 120, // increased container height
          width: 250,
          decoration: BoxDecoration(
            color: Color(0xff9a83e5), // #874CCC
            borderRadius: BorderRadius.circular(70), // Adjust the value as needed
          ),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const Library()),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff9a83e5), // 0xff874CCC
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70), // Adjust the value as needed
              ),
            ),
            child: SizedBox(
              width: double.infinity,
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
        ),
        const SizedBox(height: 50),
      ],
    );
  }


}
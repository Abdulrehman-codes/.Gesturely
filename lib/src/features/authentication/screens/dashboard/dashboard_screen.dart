import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/library/library.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../../constants/text_strings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

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
          image: const AssetImage(gWelcomeScreenImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            gBoardPage2Color.withOpacity(0.2),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 20, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white), // Set icon color to white
                  color: Colors.black, // Set button color to black
                  onPressed: () {
                    // Handle left button press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () {
                    // Handle right button press
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
    backgroundImage: AssetImage(gWelcomeScreenImage),
  );

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20,),
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
        SizedBox(height: 50),
        Container(width: MediaQuery.of(context).size.width,height: 3,color: Colors.black,),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>Get.to(()=>const Library()),

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30, right: 30),
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
                    Icon(Icons.library_books),
                    SizedBox(height: 8),
                    Text(
                      "library".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30, right: 30),
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
                    Icon(Icons.library_books),
                    SizedBox(height: 8,),
                    Text(
                      "Cmd".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: ()=>Get.to(()=>const ProfileScreen()),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30, right: 30),
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
                    Icon(Icons.library_books),
                    SizedBox(height: 8),
                    Text(
                      "custom".toUpperCase(),
                      style: TextStyle(
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




// child: Scaffold(
//   body: Container(
//     alignment: Alignment.center,
//     padding: const EdgeInsets.all(30.0),
//     child: IconButton(
//       onPressed: (){
//         Get.to(()=>const ProfileScreen());
//        // AuthenticationRepository.instance.logout();
//     },
//       icon:const Image(image: AssetImage(gGoogleLogoImage),),
//
//     ),
//   ),
// ),
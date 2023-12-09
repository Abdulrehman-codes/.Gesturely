import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../../constants/text_strings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>{
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {

    mediaSize=MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(gWelcomeScreenImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(gBoardPage2Color.withOpacity(0.2), BlendMode.dstATop),
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top:80, child: _buildTop()),
          Positioned(bottom:0, child: _buildBottom()),
        ],),
      ),
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
    );
  }
  Widget _buildTop(){
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.handshake,
            size: 100,
            color: Colors.white,
          ),
          Text("GESTURES",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
            letterSpacing: 2
          ),),
        ],
      ),
    );
  }
  Widget _buildBottom(){
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: _buildForm(),
      ),
    );
  }
  Widget _buildForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Welcome",style: TextStyle(
          color: Colors.black,
          fontSize: 64,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(height: 100),
        Row(

          children: [

            const SizedBox(
              width: 10.0,
            ),
               ElevatedButton(

                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      // Adjust the radius as needed
                    ),
                  ),
                  child: SizedBox(
                    width: 50,
                    height: 60,// Set the width to make it square
                    child: Center(
                      child: Text(
                        "Library".toUpperCase(),
                      ),
                    ),
                  ),
                ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30,right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  // Adjust the radius as needed
                ),
              ),
              child: SizedBox(
                width: 50,
                height: 60,// Set the width to make it square
                child: Center(
                  child: Text(
                    "Library".toUpperCase(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30,right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  // Adjust the radius as needed
                ),
              ),
              child: SizedBox(
                width: 50,
                height: 60,// Set the width to make it square
                child: Center(
                  child: Text(
                    "Library".toUpperCase(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 50,),

      ],
    );
  }
}
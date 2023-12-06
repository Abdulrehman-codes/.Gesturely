import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget{
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30.0),
        child: IconButton(
          onPressed: (){
            Get.to(()=>const ProfileScreen());
           // AuthenticationRepository.instance.logout();
        },
          icon:const Image(image: AssetImage(gGoogleLogoImage),),

        ),
      ),
    );
  }


}
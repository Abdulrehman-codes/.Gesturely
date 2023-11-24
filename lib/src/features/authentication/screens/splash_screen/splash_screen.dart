import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fyp/dynamic_theme.dart';
import 'package:fyp/main.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget{
  SplashScreen({super.key});

  final splashController =Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Stack(
        children: [
          Obx(()=> AnimatedPositioned(
              duration: const Duration(milliseconds: 2600),
              top: splashController.animate.value ? 300 : 200,
              right: splashController.animate.value ? 70 : -30,
              child: Image(
                width: 200,
                height: 200,
                image: AssetImage(gSplashTopIcon),
              ),
            ),
          ),
          Obx(()=> AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 80,
              left: splashController.animate.value? gDefaultSize : -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value? 1 :0,
              child: Column(
                children: [
                  Text(gAppName, style: Theme
                      .of(context)
                      .textTheme
                      .headline3,),
                  Text(gAppTagLine, style: Theme
                      .of(context)
                      .textTheme
                      .headline2,)
                ],
              ),
            ),
            ),
          ),
          Obx(()=> AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              bottom: splashController.animate.value ? 0: -50,
              child: Image(
                  width:400,
                  //height:200,
                  image: AssetImage(gSplashImage)),
            ),
          ),
          Positioned(
              bottom: 40,
              right: gDefaultSize,
              child: Container(
                width: gSplashContainerSize,
                height: gSplashContainerSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: gPrimaryColor
                ),
              ))
        ],
      ),
    );
  }


}
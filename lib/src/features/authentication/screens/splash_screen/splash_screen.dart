import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          GFadeInAnimation(durationInMs: 1600,
          animate: GAnimatePosition(
              topAfter: 300,
              topBefore: 200,
              rightAfter: 70,
            rightBefore: -30
          ),
          child: const Image(width:200,height:200,image: AssetImage(gSplashTopIcon)),
          ),
          GFadeInAnimation(
            durationInMs: 1600,
                animate: GAnimatePosition(topBefore: 80,
                topAfter: 80,
                leftAfter: gDefaultSize,
                leftBefore: -80),
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
          GFadeInAnimation(
                durationInMs: 2000,
              animate:GAnimatePosition(bottomBefore: -100,
              bottomAfter: 0),
              child: const Image(
                  width:400,
                  //height:200,
                  image: AssetImage(gSplashImage)),
            ),
          
          //
          // Positioned(
          //     bottom: 40,
          //     right: gDefaultSize,
          //     child: Container(
          //       width: gSplashContainerSize,
          //       height: gSplashContainerSize,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: gPrimaryColor
          //       ),
          //     ))
        ],
      ),
    );
  }


}


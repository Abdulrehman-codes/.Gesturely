import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode?[ const Color(0xFFffffff), const Color(0xFF000000)]:[ const Color(0xffffb789), const Color(0xffac99df)] ,
          stops: [.10,.4]
        ),
      ),
      child: Scaffold(
          //backgroundColor: isDarkMode ? Colors.transparent : gPrimaryColor,
        backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              GFadeInAnimation(
                durationInMs: 1200,
                animate: GAnimatePosition(
                  bottomAfter: 0,
                  bottomBefore: -100,
                  leftAfter: 0,
                  leftBefore: 0,
                  rightBefore: 0,
                  rightAfter: 0,
                  topAfter: 0,
                  topBefore: 0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(gDefaultSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: const AssetImage(gWelcomeScreenImage),
                        height: height * 0.4,
                      ),
                      Column(
                        children: [
                          Text(
                            gWelcomeTitle,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(height: 30,),
                          Text(
                            gWelcomeSubtitle,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.to(
                                      () => const LoginScreen(),
                                  transition: Transition.fadeIn, // Fade-in transition for the new screen
                                )!.then((value) {
                                  // Code here will be executed after the new screen is popped.
                                  // You can put any additional code you want to execute after navigation.
                                  // For example, you can use this callback to trigger actions on the previous screen.
                                });
                              },
                              child: Text(gLogin.toUpperCase(), style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                      () => const SignUpScreen(),
                                  transition: Transition.fadeIn, // Fade-in transition for the new screen
                                );
                              },
                              child: Text(gSignup.toUpperCase()),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

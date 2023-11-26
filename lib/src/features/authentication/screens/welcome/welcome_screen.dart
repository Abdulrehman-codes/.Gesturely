import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
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
    return Scaffold(
        backgroundColor: isDarkMode ? gSecondaryColor : gPrimaryColor,
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
                      image: const AssetImage(gWelcomeImage),
                      height: height * 0.4,
                    ),
                    Column(
                      children: [
                        Text(
                          gWelcomeTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          gWelcomeSubtitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () =>Get.to(()=>const LoginScreen()),
                                child: Text(gLogin.toUpperCase()))),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(gSignup.toUpperCase()))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

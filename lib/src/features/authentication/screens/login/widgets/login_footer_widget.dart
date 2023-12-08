import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/social_button.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/login_controller.dart';
import 'package:fyp/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

class Loginfooterwidget extends StatelessWidget {
  const Loginfooterwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      padding:
          const EdgeInsets.only(top: gDefaultSize-10, bottom: gDefaultSize),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("OR",style: TextStyle(fontSize: 15),),
          const SizedBox(height: gFormHeight - 10),
          Obx(() => GSocialButton(
                image: gGoogleLogoImage,
                text: gSignInWithGoogle,
                isLoading: controller.isGoogleLoading.value ? true : false,
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.isGoogleLoading.value
                        ? () {}
                        : () => controller.googleSignIn(),
              )),
          const SizedBox(height: gFormHeight - 20),
        ],
      ),
    );
  }
}

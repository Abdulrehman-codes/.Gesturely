import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/social_button.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/login_controller.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(gDefaultSize),
            child:  Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const FormHeaderWidget(
                    image: gWelcomeImage,
                    title: gSignUpTitle,
                    subTitle: gSignUpSubTitle
                ),
                const SignUpFormWidget(),
                Column(
                  children: [
                    const Text("OR"),
                    const SizedBox(height: gFormHeight-20),
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
                    TextButton(onPressed: (){
                      Get.offAll(()=>const LoginScreen());
                    },
                        child: Text.rich(TextSpan(
                          children: [
                            TextSpan(text: gAlreadyHaveAnAccount,style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(text: gLogin.toUpperCase(),style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.blue))
                          ]
                        )))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


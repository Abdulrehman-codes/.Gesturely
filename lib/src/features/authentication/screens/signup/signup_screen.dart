import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text("OR"),
                    SizedBox(height: gFormHeight-20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(onPressed: (){},
                          icon: const Image(image: AssetImage(gGoogleLogoImage),width: 20,),
                          label: Text(gSignInWithGoogle.toUpperCase(),style: Theme.of(context).textTheme.bodyText1,),),
                    ),
                    TextButton(onPressed: (){},
                        child: Text.rich(TextSpan(
                          children: [
                            TextSpan(text: gAlreadyHaveAnAccount,style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(text: gLogin.toUpperCase(),style: Theme.of(context).textTheme.bodyText1)
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


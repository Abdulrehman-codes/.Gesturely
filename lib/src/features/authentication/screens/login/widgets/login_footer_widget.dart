import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';

class Loginfooterwidget extends StatelessWidget {
  const Loginfooterwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Image(
                image: AssetImage(gGoogleLogoImage),
                width: 20.0,
              ),
              onPressed: () {},
              label: const Text(gSignInWithGoogle)),
        ),
        const SizedBox(height: gFormHeight - 20),
        TextButton(
          onPressed: () {},
          child: const Text.rich(TextSpan(
            text: gDontHaveAnAccount,
            children:[
              TextSpan(
                text: gSignup,
                style:TextStyle(color: Colors.blue),
              ),
            ],
          ),),
        ),
      ],
    );
  }
}

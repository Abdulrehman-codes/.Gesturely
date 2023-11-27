import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: gEmail,
                hintText: gEmail,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: gPassword,
                hintText: gPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
          ),
          const SizedBox(height: gFormHeight - 20),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text(gForgotPassword)),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: Text(gLogin.toUpperCase())),
          )
        ],
      ),
    ));
  }

}


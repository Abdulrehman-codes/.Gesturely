import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/signup_controller.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(SignUpController());
    final authrepo =Get.put(AuthenticationRepository());
    final _formKey=GlobalKey<FormState>();
    bool _isPasswordVisible = false;

    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: gEmail,
                hintText: gEmail,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            controller: controller.password,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: gPassword,
                hintText: gPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed:() {_isPasswordVisible = !_isPasswordVisible;
                    _formKey.currentState!.validate();
                    },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),)),
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
                onPressed: () {
                  //if(_formKey.currentState!.validate()){
                    authrepo.loginwithEmailandPassword(controller.email.text.trim(), controller.password.text.trim());
                 // }
                }, child: Text(gLogin.toUpperCase())),
          )
        ],
      ),
    ));
  }

}


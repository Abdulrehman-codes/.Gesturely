import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/signup_controller.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey=GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: gFormHeight - 10),
      child: Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullname,
                decoration: const InputDecoration(
                  label: Text(gFullname),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  label: Text(gEmail),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                controller: controller.phoneno,
                decoration: const InputDecoration(
                  label: Text(gPhoneNo),
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                  label: Text(gPassword),
                  prefixIcon: Icon(Icons.fingerprint),
                ),
              ),
              const SizedBox(height: gFormHeight-10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                  if(_formKey.currentState!.validate()){
                    //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                    final user= UserModel(
                      email: controller.email.text.trim(),
                      password: controller.password.text.trim(),
                      fullName: controller.fullname.text.trim(),
                      phoneNo: controller.phoneno.text.trim(),
                    );

                    SignUpController.instance.createUser(user);
                  }
                },
                  child: Text(gSignup.toUpperCase()),),
              )
            ],
          )),
    );
  }
}

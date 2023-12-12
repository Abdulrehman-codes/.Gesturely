import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/primary_button.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/login_controller.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(LoginController());
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(

                controller: controller.email,
                validator: (value) {
                  const pattern =
                      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                  final regex = RegExp(pattern);
                  if (value!.isEmpty) {
                    return("Enter Email");
                  } else {
                    if (!regex.hasMatch(value)) {
                     return("Enter a valid Email" );
                    } else {
                      return null;
                    }
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline_outlined),
                  labelText: gEmail,
                  hintText: gEmail,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              const SizedBox(height: gFormHeight - 20),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value){
                    if (value!.isEmpty)
                      {
                        return( "Enter Password");
                      }

                  },
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: gPassword,
                    hintText: gPassword,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black87, width: 2.0), // Increase the width for a bold border
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black87, width: 1.0),
                      borderRadius: BorderRadius.circular(100.0), // Adjust border radius if needed
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(controller.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },

                    ),
                    // border: const OutlineInputBorder(),
                  ),
                ),
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
             Obx(() => GPrimaryButton(
                 isLoading: controller.isLoading.value? true:false,
                 text: gLogin,
                 image: gGoogleLogoImage,
                 onPressed: controller.isLoading.value?
                 (){}:(){
                   if(_formKey.currentState!.validate()){
                     controller.isLoading.value=false;
                     controller.login();
                   }
                 }
             ))
            ],
          ),
        ));
  }
}

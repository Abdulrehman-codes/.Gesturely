import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/primary_button.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/exceptions/g_exceptions.dart';
import 'package:fyp/src/features/authentication/controllers/signup_controller.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: gFormHeight - 10),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            TextFormField(
            controller: controller.fullName,
            validator: (value){
              const pattern = r'^[a-zA-Z]+$';
              final regex = RegExp(pattern);

              if(value!.isEmpty)
                {
                  Get.snackbar("Error", "Enter Name",snackPosition: SnackPosition.BOTTOM);
                }
              else if (!regex.hasMatch(value))
              {
                Get.snackbar("Error", "Digits not allowed", snackPosition: SnackPosition.BOTTOM);
              }
            },
            decoration: const InputDecoration(
              label: Text(gFullname),
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            controller: controller.email,
            validator: (value){
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
                Get.snackbar("Error", "Enter Email",
                    snackPosition: SnackPosition.BOTTOM);
              } else {
                if (!regex.hasMatch(value)) {
                  Get.snackbar("Error", "Enter a valid Email",
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  return null;
                }
              }
            },
            decoration: const InputDecoration(
              label: Text(gEmail),
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            controller: controller.phoneNo,
            validator: (value)
            {
              if(value!.isEmpty||value.length<10)
              {
                Get.snackbar("Error", "Enter valid Phone Number",snackPosition: SnackPosition.BOTTOM);
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text(gPhoneNo),
              prefixIcon: Icon(Icons.numbers),
              prefixText: "+92 ",
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          Obx(
                () =>
                TextFormField(
                  controller: controller.password,
                  validator: (value) {
                    RegExp regex =
                    RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                    if (value!.isEmpty) {
                      Get.snackbar("Error", "Enter password",snackPosition: SnackPosition.BOTTOM);
                    } else {
                      if (!regex.hasMatch(value)) {
                        Get.snackbar("Error", "Password Must Contain \n 1 Uppercase Alphabet \n 1 Lowercase Alphabet \n 1 Digit",snackPosition: SnackPosition.BOTTOM);
                      }
                    }
                  },
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                      label: const Text(gPassword),
                      prefixIcon: const Icon(Icons.fingerprint),
                      suffixIcon: IconButton(
                        icon: controller.showPassword.value
                            ? const Icon(LineAwesomeIcons.eye)
                            : const Icon(LineAwesomeIcons.eye_slash),
                        onPressed: () =>
                        controller.showPassword.value =
                        !controller.showPassword.value,)),
                ),
          ),
          const SizedBox(height: gFormHeight - 10),
          Obx(
                  () =>
                  GPrimaryButton(
                    isLoading: controller.isLoading.value? true:false,
                      text: gSignup,
                      image: gGoogleLogoImage,
                      onPressed: controller.isLoading.value?(){}:(){
                      if(_formKey.currentState!.validate())
                        {
                          controller.isLoading.value=false;
                          controller.createUser();
                        }
                      },

          )
      )

      ],
    )),
    );
  }
}

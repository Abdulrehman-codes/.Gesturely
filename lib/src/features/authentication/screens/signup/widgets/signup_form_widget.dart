
import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/primary_button.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
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
            decoration: const InputDecoration(
              label: Text(gFullname),
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              label: Text(gEmail),
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          TextFormField(
            controller: controller.phoneNo,
            decoration: const InputDecoration(
              label: Text(gPhoneNo),
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: gFormHeight - 20),
          Obx(
                () =>
                TextFormField(
                  controller: controller.password,
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
                      onPressed: controller.isLoading.value?(){}:()=>controller.createUser(),

          )
      )

      ],
    )),
    );
  }
}

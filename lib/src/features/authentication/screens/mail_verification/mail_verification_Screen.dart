import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/mail_verfication_controller.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: gDefaultSize * 5,
              left: gDefaultSize,
              right: gDefaultSize,
              bottom: gDefaultSize * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon (LineAwesomeIcons.envelope_open, size: 100),
              const SizedBox (height: gDefaultSize),
              Text(gEmailVerificationTitle.tr, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium),
              const SizedBox (height: gDefaultSize),
              Text(
                gEmailVerificationSubTitle.tr,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox (height: gDefaultSize * 2),
              SizedBox(
                width: 200,
                child: OutlinedButton(child: Text(gContinue.tr,style: Theme.of(context).textTheme.bodyMedium,),
                    onPressed: () => controller.manuallyCheckEmailVerificationStatus()
                ),
              ), const SizedBox(height: gDefaultSize * 2),
              TextButton(
                onPressed: () => controller.sendVerificationEmail(),
                child: Text(gResendEmailLink.tr),
              ), // TextButton
              TextButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LineAwesomeIcons.alternate_long_arrow_left),
                    const SizedBox(width: 5),
                    Text(gBackToLogin.tr.toLowerCase()),
                  ],
                ), // Row
              ),
            ], // TextButton
          ), // Column
        ), // Padding
      ),
    );
  } // SingleChildScrollView
}

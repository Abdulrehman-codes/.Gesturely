import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/opt_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget{
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OTPController());

    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(gDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(gOtpTitle,style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 80.0,
            )),
            Text(gOtpSubTitle.toUpperCase(),style: Theme.of(context).textTheme.headline6,),
            const SizedBox(height: 40.0),
            const Text(gOtpMessage,textAlign: TextAlign.center,),
            const SizedBox(height: 20.0),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code){
                otp=code;
                controller.verifyOTP(otp);
                  },
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  controller.verifyOTP(otp);
                },
                child: const Text(gNext),
              ),
            )
          ],
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:get/get.dart';


class ForgetPasswordPhoneScreen extends StatelessWidget{
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(gDefaultSize),
              child: Column(
                children: [
                  const SizedBox(height: gDefaultSize * 4,),
                  const FormHeaderWidget(
                    image: gForgetPasswordImage,
                    title: gForgetPasswordTitle,
                    subTitle: gNull,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    heightBetween: 30,
                    textAlign: TextAlign.center,

                  ),
                  const SizedBox(height: gFormHeight,),
                  Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text(gPhoneNo),
                              hintText: gPhoneNo,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){
                            Get.to(()=>const OTPScreen());
                          }, child: Text(gNext)))
                        ],
                      ))

                ],
              ),
            ),
          )),
    );
  }



}
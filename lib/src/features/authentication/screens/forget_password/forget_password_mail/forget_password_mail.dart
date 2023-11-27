import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';


class ForgetPasswordMailScreen extends StatelessWidget{
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(gDefaultSize),
              child: Column(
                children: [
                  SizedBox(height: gDefaultSize * 4,),
                  const FormHeaderWidget(
                    image: gForgetPasswordImage,
                    title: gForgetPasswordTitle,
                    subTitle: gForgetPasswordSubtitle,
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
                              label: Text(gEmail),
                              hintText: gEmail,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: Text(gNext)))
                        ],
                      ))

                ],
              ),
            ),
          )),
    );
  }



}
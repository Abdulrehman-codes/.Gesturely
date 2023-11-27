import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/foget_password_phoneno/forget_password_phone.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ForgetPasswordScreen{
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape :RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: EdgeInsets.all(gDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gForgetPasswordTitle,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              gForgetPasswordSubtitle,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 30.0),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: gEmail,
              subTitle: gResetViaEmail,
              onTap: (){
                Navigator.pop(context);
                Get.to(()=> const ForgetPasswordMailScreen());
                },
            ),
            const SizedBox(height: 20.0,),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: gPhoneNo,
              subTitle: gResetViaPhone,
              onTap: (){
                Navigator.pop(context);
                Get.to(()=> const ForgetPasswordPhoneScreen());
              },
            ),

          ],
        ),
      ),
    );
  }
}

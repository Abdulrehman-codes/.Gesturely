import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';



class MailVerificationController extends GetxController{
  late Timer _timer;

  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }

  void sendVerificationEmail() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
    }catch(e){
      Get.snackbar(gOhSnap, e.toString());
    }

  }
  void setTimerForAutoRedirect(){
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user= FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
        timer.cancel();
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }

  void manuallyCheckEmailVerificationStatus(){
    FirebaseAuth.instance.currentUser?.reload();
    final user=FirebaseAuth.instance.currentUser;
    if(user!.emailVerified){
      AuthenticationRepository.instance.setInitialScreen(user);
    }
  }

}
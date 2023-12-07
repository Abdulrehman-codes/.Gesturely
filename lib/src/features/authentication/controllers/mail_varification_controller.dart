import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart';



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
      await AuthenticationRepository.instance.sendEmailVarification();
    }catch(e){


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

  void manuallyCheckEmailVerificationStatus(){}

}
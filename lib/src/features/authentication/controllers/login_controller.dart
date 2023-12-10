import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/exceptions/g_exceptions.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  RxBool showPassword = false.obs;
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginFormKey=GlobalKey<FormState>();


  final isLoading=false.obs;
  final isGoogleLoading=false.obs;

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  Future<void> login()async{
    try {
      isLoading.value=true;
      final auth=AuthenticationRepository.instance;
      await auth.loginwithEmailandPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    }catch(e){
    isLoading.value=false;
    Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM,duration: const Duration(seconds: 3));
    }
  }

  Future<void> googleSignIn() async{
    try{
      isGoogleLoading.value=true;
      final auth=AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value=false;
      auth.setInitialScreen(auth.firebaseUser);
    }catch(e){
      isGoogleLoading.value=false;
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM,duration: const Duration(seconds: 3));
    }
  }


}
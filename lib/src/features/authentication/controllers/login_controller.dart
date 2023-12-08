
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  final showPassword = false.obs;
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginFormKey=GlobalKey<FormState>();


  final isLoading=false.obs;
  final isGoogleLoading=false.obs;

  Future<void> login()async{
    try {
      isLoading.value=true;
      // if(loginFormKey.currentState!.validate()){
      //   isLoading.value=false;
      //   return;
      // }
      final auth=AuthenticationRepository.instance;
      await auth.loginwithEmailandPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser as User?);
    } catch (e) {
      isLoading.value=false;
      Get.snackbar(gOhSnap, e.toString());
    }
  }



}
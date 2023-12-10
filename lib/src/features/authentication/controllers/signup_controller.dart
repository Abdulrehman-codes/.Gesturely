import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final isLoading = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final showPassword = true.obs;

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserwithEmailandPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),snackPosition: SnackPosition.BOTTOM,));
    }
  }
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  Future<void> createUser() async {
    try {
      isLoading.value = true;

      final user = UserModel(
        email: email.text.trim(),
        password: password.text.trim(),
        fullName: fullName.text.trim(),
        phoneNo: '+92${phoneNo.text.trim()}',);

      final auth = AuthenticationRepository.instance;
      await AuthenticationRepository.instance.createUserwithEmailandPassword(
          user.email, user.password);
      await UserRepository.instance.createUser(user);
      auth.setInitialScreen(auth.firebaseUser);
    }catch(e){
      isLoading.value=false;
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM,duration: const Duration(seconds: 3));
    }
    // phoneAuthentication(user.phoneNo);
    // Get.to(()=> const OTPScreen());
  }

}
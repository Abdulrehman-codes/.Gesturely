import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname= TextEditingController();
  final phoneno= TextEditingController();

  final userRepo= Get.put(UserRepository());

  void registerUser(String email, String password){
     String? error= AuthenticationRepository.instance.createUserwithEmailandPassword(email, password) as String?;
     if(error!=null){
       Get.showSnackbar(GetSnackBar(message: error.toString(),));
     }
  }
  void phoneAuthentication(String phoneNo){
      AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
  Future<void> createUser(UserModel user) async {
      await userRepo.createUser(user);
      registerUser(user.email, user.password);
      // phoneAuthentication(user.phoneNo);
      // Get.to(()=> const OTPScreen());
  }
  // void login(String email,String password){
  //   String? error= AuthenticationRepository.instance.loginwithEmailandPassword(email, password) as String?;
  //   if(error!=null){
  //     Get.showSnackbar(GetSnackBar(message: error.toString(),));
  //   }
  // }
}
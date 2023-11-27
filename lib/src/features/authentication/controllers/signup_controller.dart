import 'package:flutter/material.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname= TextEditingController();
  final phoneno= TextEditingController();

  void registerUser(String email, String password){
      AuthenticationRepository.instance.createUserwithEmailandPassword(email, password);
  }
}
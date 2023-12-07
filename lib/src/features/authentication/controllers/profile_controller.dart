import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();



  final _authRepo =Get.put(AuthenticationRepository());
  final _userRepo =Get.put(UserRepository());

    getUserData() {
    final email=_authRepo.firebaseUser.value?.email;
    if(email!=null){
      return _userRepo.getUserDetails(email);
    }
    else{
      Get.snackbar("Error", "Login to continue");
    }
    
  }

  Future<List<UserModel>>getAllUser() async {
    return await _userRepo.allUser();
  }

  updateRecord(UserModel user) async {
      await _userRepo.updateUserRecord(user);


  }
}
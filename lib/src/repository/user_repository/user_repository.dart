import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong.  Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      //print(error.toString());
    });
  }

  Future<UserModel>getUserDetails(String email) async {
    final snapshot=await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData= snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData;
  }

  Future<List<UserModel>>allUser() async {
    final snapshot=await _db.collection("Users").get();
    final userData= snapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async{
    await _db.collection("Users").doc(user.id).update(user.toJson());
    try {
      User? userpass = FirebaseAuth.instance.currentUser;
      if (userpass != null) {
        await userpass.updatePassword(user.password);
        print("Password updated successfully");
      } else {
        print("No user is currently signed in");
      }
    } catch (error) {
      print("Error updating password: $error");
    }
  }

}

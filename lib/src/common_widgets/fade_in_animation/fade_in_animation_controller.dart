import 'package:flutter/material.dart';
import 'package:fyp/dynamic_theme.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class FadeInAnimationController extends GetxController{
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;


  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
      animate.value = true;
    await Future.delayed(Duration(milliseconds: 5000));
    Get.to(Welcome());
  }
}
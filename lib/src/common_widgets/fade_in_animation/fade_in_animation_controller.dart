import 'package:flutter/material.dart';
import 'package:fyp/dynamic_theme.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class FadeInAnimationController extends GetxController{
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;


  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animate.value=false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.to(()=> const OnBoardingScreen());
  }
  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;

  }
}
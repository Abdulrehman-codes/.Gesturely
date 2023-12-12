import 'package:flutter/material.dart';
import 'package:fyp/dynamic_theme.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/models/model_on_boarding.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController{
  final controller = LiquidController();
  RxInt currentPage=0.obs;


  final pages=[
    OnBoardingPageWidget(model: OnBoardingModel(
        image: gBoardImage1,
        title: gBoardTitle1,
        subTitle: gBoardSubtitle1,
        counterText: gBoardCounter1,
        bgColor: gBoardPage1Color,
    )

    ),
    OnBoardingPageWidget(model: OnBoardingModel(
        image: gBoardImage2,
        title: gBoardTitle2,
        subTitle: gBoardSubtitle2,
        counterText: gBoardCounter2,
        bgColor: gBoardPage2Color,
        )

    ),
    OnBoardingPageWidget(model: OnBoardingModel(
        image: gBoardImage3,
        title: gBoardTitle3,
        subTitle: gBoardSubtitle3,
        counterText: gBoardCounter3,
        bgColor: gBoardPage3Color,
        )

    )
  ];
  skip()=>Get.offAll(()=>const Welcome(),transition: Transition.circularReveal);
  animateToNextSlide()
  {
    int nextPage=controller.currentPage+1;
    controller.animateToPage(page: nextPage);
    if (nextPage==3)
      {
        final storage = GetStorage();
        storage.write('isFirstTime', false);
        Get.offAll(()=>const Welcome(),transition: Transition.circularReveal);
      }
  }
  onPageChangedCallback(int activePageIndex)=>currentPage.value=activePageIndex;




}
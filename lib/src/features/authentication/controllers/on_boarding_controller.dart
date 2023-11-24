import 'package:flutter/material.dart';
import 'package:fyp/dynamic_theme.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/models/model_on_boarding.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:get/get.dart';
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
  skip()=>controller.jumpToPage(page: 2);
  animateToNextSlide()
  {
    int nextPage=controller.currentPage+1;
    controller.animateToPage(page: nextPage);
    if (nextPage==3)
      {
        Get.to(AppHome());
      }
  }
  onPageChangedCallback(int activePageIndex)=>currentPage.value=activePageIndex;




}
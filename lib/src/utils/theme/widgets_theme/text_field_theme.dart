import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';

class GTextFormFieldTheme{
  GTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme=
  InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      prefixIconColor: gSecondaryColor,
      floatingLabelStyle:const TextStyle(color: gSecondaryColor),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(width: 2.0,color: gSecondaryColor),
      ),
  );



  static InputDecorationTheme darkInputDecorationTheme=
  InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: gPrimaryColor,
    floatingLabelStyle:const TextStyle(color: gPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(width: 2.0,color: gPrimaryColor),
    ),
  );
}
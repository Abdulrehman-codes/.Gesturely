import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';


class GElevatedButtonTheme{
  GElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: gWhiteColor,
        backgroundColor: gSecondaryColor,
        side: BorderSide(color: gSecondaryColor),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: gButtonHeight)),
  );



  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: gSecondaryColor,
        backgroundColor: gWhiteColor,
        side: BorderSide(color: gSecondaryColor),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: gButtonHeight)),
  );
}
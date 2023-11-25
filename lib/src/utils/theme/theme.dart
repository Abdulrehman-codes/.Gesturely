import 'package:flutter/material.dart';
import 'package:fyp/src/utils/theme/widgets_theme/elevated_button_theme.dart';
import 'package:fyp/src/utils/theme/widgets_theme/outlined_button_theme.dart';
import 'package:fyp/src/utils/theme/widgets_theme/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class GAppTheme{

  GAppTheme._();  //makes it private

  static ThemeData lightTheme= ThemeData(
      brightness: Brightness.light,
      textTheme: GTextTheme.lightTextTheme,
      //elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      outlinedButtonTheme: GOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: GElevatedButtonTheme.lightElevatedButtonTheme
  );

  static ThemeData darkTheme= ThemeData(brightness: Brightness.dark,
    textTheme: GTextTheme.darkTextTheme,
    outlinedButtonTheme: GOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: GElevatedButtonTheme.darkElevatedButtonTheme
  );

}
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:fyp/src/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}): super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );

  }
}

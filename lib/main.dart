import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/firebase_options.dart';
import 'package:fyp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/utils/theme/theme.dart';
import 'package:get/get.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const CircularProgressIndicator(),
    );
  }
}

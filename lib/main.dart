import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/firebase_options.dart';
import 'package:fyp/src/features/authentication/screens/camera/camera_screen.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_preference.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  cameraScreenState = CameraScreenState();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const platform = MethodChannel('gesturely');

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _triggerScroll,
                child: const Text('Trigger Scroll'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showToast,
                child: const Text('Show Toast'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _triggerScroll() async {
    try {
      await platform.invokeMethod('scrollScreen', {"offset": 100});
    } on PlatformException catch (e) {
      print("Failed to trigger scroll: '${e.message}'.");
    }
  }

  Future<void> _showToast() async {
    try {
      await platform.invokeMethod('showToast', {"message": "Hello from Flutter!"});
    } on PlatformException catch (e) {
      print("Failed to show toast: '${e.message}'.");
    }
  }
}

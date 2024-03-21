import 'dart:developer';
import 'package:android_intent/android_intent.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:fyp/src/features/authentication/screens/operations/screen_scroll.dart';
import 'package:fyp/src/features/authentication/screens/operations/brightness.dart';
import 'package:fyp/src/features/authentication/screens/operations/volume.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription>? cameras;

// Declare a global variable to hold the instance of CameraScreenState
CameraScreenState? cameraScreenState;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   cameraScreenState = CameraScreenState(); // Initialize the CameraScreenState instance
//   runApp(const CameraApp());
// }

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Camera App',
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);


  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  var channel =const MethodChannel("gesturely");

  CameraController? cameraController;
  CameraImage? imgCamera;
  String result = '';
  bool isCameraRunning = false;
  VolumeController volume = VolumeController();
  BrightnessScreen brightness = BrightnessScreen();
  ScrollController scroll = ScrollController();
  FlutterVision vision = FlutterVision();
  bool isRunning=true;

  showToast(){
    channel.invokeMethod("showToast");
  }

  scrollScreen()  {

      channel.invokeMethod("scrollScreen"); // Provide the offset value here
  }

  increaseBrightness(){
    channel.invokeMethod("increaseBrightness", {"level": 50});

  }
  decreaseBrightness(){
    channel.invokeMethod("decreaseBrightness", {"level": 50});
  }
  whatsappmsg(){
    channel.invokeMethod("openWhatsAppAndSendMessage",{"phNo":"03044555450","msg":"03044555450"});
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    _minimizeApp();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    vision.closeYoloModel();
    super.dispose();
  }

  loadModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/model5.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false,
      );
    } catch (e) {
      debugPrint("Failed to load model: $e");
    }
  }

  initializeCamera() {
    cameraController = CameraController(
      cameras![1],
      ResolutionPreset.ultraHigh,
    );

    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraRunning = true;
        cameraController?.startImageStream((imageFromStream) {
          setState(() {
            imgCamera = imageFromStream;
          });
          runModelOnStreamFrame();
        });
      });
    });
  }

  stopCamera() {
    if (isCameraRunning) {
      cameraController?.stopImageStream();
      cameraController?.dispose();
      setState(() {
        isCameraRunning = false;
      });
    }
  }

  void toggleCameraAndModel() {

    if (isCameraRunning) {
      stopCamera();
    } else {
      initializeCamera();
    }
  }
  runModelOnStreamFrame() async {
    if (imgCamera != null) {
      try {
        final recognitions = await vision.yoloOnFrame(
          bytesList: imgCamera!.planes.map((plane) => plane.bytes).toList(),
          imageWidth: imgCamera!.width,
          imageHeight: imgCamera!.height,
          iouThreshold: 0.4,
          classThreshold: 0.4,
          confThreshold: 0.4,
        );


        print(recognitions);
        if (recognitions.isNotEmpty) {
          for (var detection in recognitions) {
            switch (detection["tag"]) {
              case "call":
              case "dislike":
              case "four":
              case "like":
              case "mute":
                ScreenScroll.scrollUp();
              case "ok":
              case "one":
                ScreenScroll.scrollDown();
              case "fist":
              case "peace":
              case "peace_inverted":
              case "rock":
              case "stop":
              case "stop_inverted":
              case "three2":
              case "two_up":
              case "two_up_inverted":
                VolumeController.decreaseVolume();
                break;
              case "palm":
                print("Increase Volume");
                VolumeController.increaseVolume();
                break;
              default:
                debugPrint("Unknown tag: ${detection['tag']}");
                break;
            }
          }
        }
      } catch (e) {
        debugPrint("Error running model: $e");
      }
    }
  }

  Future<void> _minimizeApp() async {
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {

        // Check if overlay permission is granted
        final bool isPermissionGranted = await FlutterOverlayWindow.isPermissionGranted();
        if (isPermissionGranted && isRunning) {
          // Open overlay content
          await FlutterOverlayWindow.showOverlay(
            overlayContent: 'This is a floating overlay!',
            height: 300,
            width: 400,
            alignment: OverlayAlignment.center,
            enableDrag: true, // Enable dragging the overlay
          );
          isRunning=false;
          AndroidIntent intent = const AndroidIntent(
            action: 'android.intent.action.MAIN',
            category: 'android.intent.category.HOME',
          );
          await intent.launch();

        } else {
          // Request overlay permission
          final bool? isPermissionGrantedAfterRequest = await FlutterOverlayWindow.requestPermission();
          if (isPermissionGrantedAfterRequest!) {
            // Open overlay content after permission is granted
            await FlutterOverlayWindow.showOverlay(
              overlayContent: 'This is a floating overlay!',
              enableDrag: true, // Enable dragging the overlay
            );
          }
        }
      } else {
        // Handle other platforms
      }
    } catch (e) {
      print('Error minimizing app: $e');
    }
  }
  Future<void> _runMethod(
      BuildContext context,
      Future<void> Function() method,
      ) async {
    try {
      await method();
    } catch (error) {
      log(
        name: 'Dash Bubble Playground',
        error.toString(),
      );

      print("Error with the bubble");
    }
  }

  Future<void> _startBubble(
      BuildContext context, {
        BubbleOptions? bubbleOptions,
        NotificationOptions? notificationOptions,
        VoidCallback? onTap,
        Function(double x, double y)? onTapDown,
        Function(double x, double y)? onTapUp,
        Function(double x, double y)? onMove,
      }) async {
    await _runMethod(
      context,
          () async {
        final hasStarted = await DashBubble.instance.startBubble(
          bubbleOptions: bubbleOptions,
          notificationOptions: notificationOptions,
          onTap: onTap,
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onMove: onMove,
        );

        print(hasStarted ? 'Bubble Started' : 'Bubble has not Started',
        );
      },
    );
  }

  Future<void> _stopBubble(BuildContext context) async {
    await _runMethod(
      context,
          () async {
        final hasStopped = await DashBubble.instance.stopBubble();

        print( hasStopped ? 'Bubble Stopped' : 'Bubble has not Stopped'
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              top: 50, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  toggleCameraAndModel();
                 // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text(isCameraRunning ? 'Stop Camera & Model' : 'Start Camera & Model'),
              ),
            ),
            Positioned(
              top: 100, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  increaseBrightness();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('increase brightness'),
              ),
            ),Positioned(
              top: 150, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  decreaseBrightness();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('decrease brightness'),
              ),
            ),
            Positioned(
              top: 200, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  VolumeController.increaseVolume();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('Volume increase'),
              ),
            ),
            Positioned(
              top: 250, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  VolumeController.decreaseVolume();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('Volume Decrese'),
              ),
            ),
            Positioned(
              top: 300, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  whatsappmsg();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('Whatsapp Msg'),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: ()
                    {
                      _startBubble(
                        context,
                        bubbleOptions: BubbleOptions(
                          bubbleIcon: 'github_bubble',
                          startLocationX: 0,
                          startLocationY: 100,
                          bubbleSize: 60,
                          opacity: 1,
                          enableClose: true,
                          closeBehavior: CloseBehavior.fixed,
                          distanceToClose: 100,
                          enableAnimateToEdge: true,
                          enableBottomShadow: false,
                          keepAliveWhenAppExit: false,
                        ),
                        notificationOptions: NotificationOptions(
                          id: 1,
                          title: 'Dash Bubble Playground',
                          body: 'Dash Bubble service is running',
                          channelId: 'dash_bubble_notification',
                          channelName: 'Dash Bubble Notification',
                        ),
                        onTap: () => decreaseBrightness(),
                      );
                    },
                    child: const Text('Bubble'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
import 'dart:developer';
import 'dart:ui';
import 'package:android_intent/android_intent.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';
import 'package:fyp/src/features/authentication/screens/operations/brightness.dart';
import 'package:fyp/src/features/authentication/screens/operations/volume.dart';

List<CameraDescription>? cameras;

CameraScreenState? cameraScreenState;



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
  Gestures gestures = Gestures(); // Create an instance of Gestures


  showToast(String message){
    channel.invokeMethod("showToast",{"message": message});
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
    String phoneNumber="03044555450";
    String message="Hello from the other side";

    channel.invokeMethod('openWhatsAppAndSendMessage', {
      'phNo': phoneNumber,
      'msg': message,
    });
  }

  callOne(){
      String phoneNumber = "03044555450";
      channel.invokeMethod("callOne", {"phNo": phoneNumber});
    // else{
    //   showToast("Permission Not Granted");
    // }
  }
  swipeLTR(){
    channel.invokeMethod("swipeLTR");
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

  GestureAction? getGestureActionFromTag(String tag) {
    switch (tag) {
      case "call":
        return GestureAction.call;
      case "dislike":
        return GestureAction.dislike;
      case "like":
        return GestureAction.like;
      case "palm":
        return GestureAction.palm;
      case "four":
        return GestureAction.four;
      case "mute":
        return GestureAction.mute;
      case "ok":
        return GestureAction.ok;
      case "one":
        return GestureAction.one;
      case "fist":
        return GestureAction.fist;
      case "peace":
        return GestureAction.peace;
      case "peace_inverted":
        return GestureAction.peace_inverted;
      case "rock":
        return GestureAction.rock;
      case "stop":
        return GestureAction.stop;
      case "stop_inverted":
        return GestureAction.stop_inverted;
      case "three2":
        return GestureAction.three2;
      case "two_up":
        return GestureAction.two_up;
      case "two_up_inverted":
        return GestureAction.two_up_inverted;
      default:
        return GestureAction.no_gesture;
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
            String gestureTag = detection["tag"];
            GestureAction? action = getGestureActionFromTag(gestureTag);
            if (action != null) {
              showToast("Detected : $gestureTag");
              gestures.perform(action);
            }
          }
        }
      }catch (e) {
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
              top: 350, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  callOne();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('Call'),
              ),
            ),
            Positioned(
              top: 400, // Adjust the top position as needed
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  startDefaultPlayer();
                  // toggleCameraAndModel(); // Start or stop camera and model
                },
                child: Text('Start Player'),
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
                        onTap: () => swipeLTR(),
                      );
                      _minimizeApp();
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
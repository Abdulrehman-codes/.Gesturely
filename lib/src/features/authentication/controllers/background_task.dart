import 'dart:async';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:fyp/src/features/authentication/screens/operations/volume.dart';

void runBackgroundTask(SendPort sendPort, Stream<CameraImage> cameraStream) async {
  final FlutterVision vision = FlutterVision();
  try {
    await vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/model.tflite',
      modelVersion: "yolov8",
      quantization: false,
      numThreads: 1,
      useGpu: false,
    );
  } catch (e) {
    sendPort.send("Failed to load model: $e");
    return; // Exit the function if model loading fails
  }

  // Process frames from camera stream
  cameraStream.listen((imgCamera) async {
    if (imgCamera != null) {
      try {
        // Process frame using the loaded model
        final recognitions = await vision.yoloOnFrame(
          bytesList: imgCamera.planes.map((plane) => plane.bytes).toList(),
          imageHeight: imgCamera.height,
          imageWidth: imgCamera.width,
          iouThreshold: 0.4,
          confThreshold: 0.4,
          classThreshold: 0.5,
        );

        // Process object detections
        if (recognitions.isNotEmpty) {
          for (var detection in recognitions) {
            switch (detection["tag"]) {
              case "call":
                VolumeController.decreaseVolume();
                break;
              case "dislike":
                VolumeController.decreaseVolume();
                break;
              case "fist":
                VolumeController.increaseVolume();
                break;
            // Handle other detections as needed
              default:
                print("Unhandled detection: ${detection["tag"]}");
                break;
            }
          }
        }
      } catch (e) {
        sendPort.send("Error running model: $e");
      }
    }
  });
}

void startBackgroundIsolate(Stream<CameraImage> cameraStream) {
  final ReceivePort receivePort = ReceivePort();
  Isolate.spawn(
    _isolateEntryPoint,
    {"sendPort": receivePort.sendPort, "cameraStream": cameraStream},
    debugName: 'background_isolate',
  );
}

void _isolateEntryPoint(Map<String, dynamic> message) {
  final SendPort sendPort = message['sendPort'];
  final Stream<CameraImage> cameraStream = message['cameraStream'];

  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    if (message is SendPort) {
      // Start running the background task with camera stream
      runBackgroundTask(message, cameraStream);
    }
  });
}

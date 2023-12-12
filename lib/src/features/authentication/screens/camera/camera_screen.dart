import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![1], ResolutionPreset.max);
      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() => _isCameraInitialized = true);
        _timer = Timer(Duration(seconds: 3), () => _captureAndSavePhoto());
      });
    }
  }

  Future<void> _captureAndSavePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    final XFile file = await _controller!.takePicture();
    final Directory? appDirectory = await getApplicationDocumentsDirectory();
    final String picturePath = '${appDirectory!.path}/${DateTime.now().toIso8601String()}.png';
    final File pictureFile = File(picturePath);

    await pictureFile.writeAsBytes(await file.readAsBytes());

    // Save the photo to the device's gallery.
    final result = await ImageGallerySaver.saveFile(picturePath);

    if (result != null) {
      // Show a message that the picture is taken.
      Fluttertoast.showToast(
        msg: "Picture Taken",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: CameraPreview(_controller!), // Display the camera preview.
    );
  }
}

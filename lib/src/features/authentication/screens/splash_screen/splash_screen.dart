import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final String videoPath = 'assets/videos/splash_videos/logo.mp4'; // Update this path

  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => OnBoardingScreen(), // Replace with your next screen
    ));
  }


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setPlaybackSpeed(1.25); // Set the playback speed to 1.25x
        _controller.play();
      }).onError((error, stackTrace) {
        print("Error initializing video player: $error");
      });

    _controller.addListener(() {
      final bool isEnded = _controller.value.position >= _controller.value.duration;
      if (isEnded) {
        navigateToNextScreen(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
          children: <Widget>[
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ],
        )
            : SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

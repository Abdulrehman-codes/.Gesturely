import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../../../../constants/video_strings.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:fyp/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode? Colors.black : Colors.white,
      body: Stack(
        children: [
          // GFadeInAnimation(
          //   durationInMs: 1600,
          //       animate: GAnimatePosition(topBefore: 0,
          //       topAfter: 80,
          //         leftBefore: 0,
          //         leftAfter: 0,
          //         rightAfter: 0,
          //         rightBefore: 0,
          //       ),
          //     child: Column(
          //       children: [
          //         Text(gAppName,textAlign: TextAlign.center ,style: Theme
          //             .of(context)
          //             .textTheme
          //             .headline3,),
          //       ],
          //     ),
          //   ),
          GFadeInAnimation(
            durationInMs: 1000,
            animate:GAnimatePosition(
              topBefore: 0,
              topAfter: 80,
              leftBefore: 0,
              leftAfter: 0,
              rightAfter: 0,
              rightBefore: 0,),
            child: Image(
              width:100,
              height:50,
              image: isDarkMode? const AssetImage(gesturelyWhite):const AssetImage(gesturelyBlack),
            ),),
          GFadeInAnimation(
            durationInMs: 1000,
            animate:GAnimatePosition(bottomBefore: -100,
                bottomAfter: 200),
            child: const Image(
                width:400,
                //height:200,
                image: AssetImage(gSplashImage)),
          ),

          //
          // Positioned(
          //     bottom: 40,
          //     right: gDefaultSize,
          //     child: Container(
          //       width: gSplashContainerSize,
          //       height: gSplashContainerSize,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: gPrimaryColor
          //       ),
          //     ))
        ],
      ),
    );
  }


}




// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // Replace the video URL with your own video file or network URL
//     _controller = VideoPlayerController.asset('assets/splash_video.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize();
//
//     // Uncomment the next line to enable looping of the video
//     // _controller.setLooping(true);
//
//     _controller.play();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the VideoPlayerController has finished initialization, use it to display the video
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             );
//           } else {
//             // If the VideoPlayerController is still initializing, show a loading spinner
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

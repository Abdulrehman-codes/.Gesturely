import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key
  }):super(key:key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          // image: const AssetImage(gWelcomeImage),
          // height: size.height * 0.2,
          width:100,
          height:50,
          image: isDarkMode? AssetImage(gesturelyWhite):AssetImage(gesturelyBlack),
        ),
        Text(
          gLoginTitle,
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),

      ],
    );
  }
}


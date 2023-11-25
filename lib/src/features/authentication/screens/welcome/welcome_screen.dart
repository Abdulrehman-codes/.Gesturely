import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? gSecondaryColor : gPrimaryColor,
      body: Container(
        padding: EdgeInsets.all(gDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(gWelcomeImage),height: height* 0.4,),
            Column(
              children: [
                Text(gWelcomeTitle, style: Theme.of(context).textTheme.headlineMedium,),
                Text(gWelcomeSubtitle, style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
              ],
            ),


            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text(gLogin.toUpperCase()))),
                SizedBox(width: 10.0,),
                Expanded(child: ElevatedButton(onPressed: (){}, child: Text(gSignup.toUpperCase()))),
              ],
            )
          ],
        ),
      )

    );
  }

}
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(gWelcomeImage),
          height: size.height * 0.2,
        ),
        Text(
          gLoginTitle,
          style: Theme
              .of(context)
              .textTheme
              .headline2,
        ),
        Text(
          gLoginSubTitle,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1,
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.heightBetween,
    this.textAlign,
    this.crossAxisAlignment=CrossAxisAlignment.start,

  }):super(key:key);

  final String image,title,subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final heightBetween;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image:  AssetImage(image),
          height: size.height * 0.2,
        ),
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1,
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/features/authentication/models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model ;

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(gDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       // mainAxisSize: MainAxisSize.max,
       // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image), height: size.height*0.4,),
          Column(
            children: [
              Text(model.title,style: Theme.of(context).textTheme.headline2,),
              Text(model.subTitle,textAlign: TextAlign.center,),

            ],
          ),
          Text(model.counterText,style: Theme.of(context).textTheme.headline6,),
          const SizedBox(height: 50.0,)
        ],
      ),);
  }
}
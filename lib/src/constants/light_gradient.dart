import 'package:flutter/material.dart';



class LightModeGradient extends StatelessWidget{
  const LightModeGradient({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffffb789),Color(0xffac99df)],
            stops: [.25,.5]
        ),
      ),
    );
  }


}
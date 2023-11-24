import 'package:flutter/material.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Padding(
        padding: EdgeInsets.all(10),
        child:Text("Welcome") ,
      ),
    );
  }

}
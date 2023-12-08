import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/button/button_loading_widget.dart';


class GPrimaryButton extends StatelessWidget{
  const GPrimaryButton({super.key,
    required this.text,
    required this.image,
    required this.onPressed,
    this.isLoading=false
  });



  final String text;
  final String image;
  final VoidCallback onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(onPressed: onPressed,style: ElevatedButton.styleFrom(
        elevation: 0,
        side: BorderSide.none,
      ),
          icon: isLoading?const SizedBox(): Image(image: AssetImage(image),width: 0,height: 0,),
          label: isLoading? const ButtonLoadingWidget()
                          : Text(text.toUpperCase(),style: const TextStyle(
            fontSize: 20
          ),))
    );
  }

}
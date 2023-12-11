import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/widgets/login_footer_widget.dart';
import 'package:fyp/src/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:fyp/src/features/authentication/screens/login/widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode?[ const Color(0xFFffffff), const Color(0xFF000000)]:[ const Color(0xffffb789), const Color(0xffac99df)] ,
              stops: [.10,.4]
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(gDefaultSize),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHeaderWidget(
                      image: gesturelyBlack, title: gLoginTitle, subTitle: gLoginSubTitle),
                  LoginForm(),
                  Loginfooterwidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

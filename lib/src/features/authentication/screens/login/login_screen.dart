import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widgets.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(gDefaultSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                    image: gWelcomeImage, title: gLoginTitle, subTitle: gLoginSubTitle),
                LoginForm(),
                Loginfooterwidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

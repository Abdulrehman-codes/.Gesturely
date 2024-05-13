import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/profile/feedback.dart';
import 'package:fyp/src/features/authentication/screens/profile/update_profle_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/user_managment/user_management.dart';
import 'package:fyp/src/features/authentication/screens/profile/widgets/profile_menu_widgets.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wiredash/wiredash.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      secret: secret,
      projectId: projectId,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: Colors.white)),
        title: Text(
          gProfile,
          style: Theme.of(context).textTheme.headline4!.copyWith(
            color: Colors.white, // Change the color of the text
          ),
        ),

        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5),
                BlendMode.color,
              ),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Image.asset(
                  gDashboard,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(gDefaultSize),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Image(
                                    image: AssetImage(gEmptyProfile),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Text(gProfileHeading,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline4!
                        //         .copyWith(color: Colors.white)),
                        // const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () =>
                                Get.to(() => const UpdateProfileScreen()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff9a83e5),
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(gEditProfile,
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff9a83e5).withOpacity(1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ProfileMenuWidget(
                            title: gMenu2,
                            icon: LineAwesomeIcons.comments,
                            onPress: () {
                              Wiredash.of(context).show();
                            },
                            textColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff9a83e5).withOpacity(1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ProfileMenuWidget(
                            title: gMenu3,
                            icon: LineAwesomeIcons.user_check,
                            onPress: () => Get.to(() => const UserManagement()),
                            textColor: Colors.white,
                          ),
                        ),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff9a83e5).withOpacity(1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ProfileMenuWidget(
                            title: gLogout,
                            icon: LineAwesomeIcons.alternate_sign_out,
                            textColor: Colors.red,
                            endIcon: false,
                            onPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Logout Confirmation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    content: Text(
                                        "Are you sure you want to log out?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuthenticationRepository
                                              .instance
                                              .logout();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(gLogout,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
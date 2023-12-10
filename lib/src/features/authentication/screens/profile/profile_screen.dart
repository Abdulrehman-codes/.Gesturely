import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/profile/update_profle_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/user_managment/user_management.dart';
import 'package:fyp/src/features/authentication/screens/profile/widgets/profile_menu_widgets.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
          icon: Icon(LineAwesomeIcons.angle_left,color:isDark?Colors.white:Colors.black)),
        title: Text(gProfile, style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),color:isDark?Colors.white:Colors.black)
        ],
      ),
      body: SingleChildScrollView(
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
                          image: AssetImage(gProfileImage),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: gPrimaryColor,
                      ),
                      child: const Icon(LineAwesomeIcons.alternate_pencil,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(gProfileHeading,
                  style: Theme.of(context).textTheme.headline4),
              Text(gProfileSubHeading,
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(gEditProfile),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: gMenu1, icon: LineAwesomeIcons.cog, onPress: () {}),
              ProfileMenuWidget(
                  title: gMenu2, icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(
                  title: gMenu3,
                  icon: LineAwesomeIcons.user_check,
                  onPress: ()=>Get.to(()=>const UserManagement())),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: gMenu4, icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                title: gLogout,
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  // Show the confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:  Text("Logout Confirmation",style: Theme.of(context).textTheme.bodyMedium),
                        content:  Text("Are you sure you want to log out?",style: Theme.of(context).textTheme.bodyMedium),
                        actions: <Widget>[
                          // Cancel button
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel",style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          // Logout button
                          TextButton(
                            onPressed: () {
                              // Perform the logout action
                              AuthenticationRepository.instance.logout();
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child:  Text(gLogout,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

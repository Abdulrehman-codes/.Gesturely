import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/profile_controller.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(gEditProfile, style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(gDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData= snapshot.data as UserModel;
                  return Column(
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
                          const SizedBox(height: 20),
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
                              child: const Icon(LineAwesomeIcons.camera,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            initialValue: userData.fullName,
                            decoration: const InputDecoration(
                              label: Text(gFullname),
                              prefixIcon: Icon(Icons.person_outline_rounded),
                            ),
                          ),
                          const SizedBox(height: gFormHeight - 20),
                          TextFormField(
                            initialValue: userData.email,
                            decoration: const InputDecoration(
                              label: Text(gEmail),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: gFormHeight - 20),
                          TextFormField(
                            initialValue: userData.phoneNo,
                            decoration: const InputDecoration(
                              label: Text(gPhoneNo),
                              prefixIcon: Icon(Icons.numbers),
                            ),
                          ),
                          const SizedBox(height: gFormHeight - 20),
                          TextFormField(
                            initialValue: userData.password,
                            decoration: const InputDecoration(
                              label: Text(gPassword),
                              prefixIcon: Icon(Icons.fingerprint),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Get.to(() => const UpdateProfileScreen()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gPrimaryColor,
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(gEditProfile),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text.rich(TextSpan(
                                  text: gJoined,
                                  style: TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text: gJoinedAt,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ])),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.1),
                                  elevation: 0,
                                  foregroundColor: Colors.red,
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                ),
                                child: const Text(gDelete),
                              )
                            ],
                          ),
                        ],
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class OTPController extends GetxController{
  static OTPController get instance=> Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified= await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const DashBoard()): Get.back();
  }
}
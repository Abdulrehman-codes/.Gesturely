import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fyp/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:fyp/src/features/authentication/screens/mail_varification/mail_varification.dart';
import 'package:fyp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:fyp/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId=' '.obs;
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    setInitialScreen(firebaseUser.value);
    //ever(firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const SplashScreen()) : user.emailVerified? Get.offAll(() => const DashBoard()) : Get.offAll(() => MailVerification());
  }



  Future<void> phoneAuthentication(String phoneno) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneno,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        codeSent: (verificationId,resendToken){
          this.verificationId.value=verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value=verificationId;
        },
        verificationFailed: (e){
          if(e.code=="invalid-phone-number"){
            Get.snackbar("Error", "The provided phone number is not valid.");
          }
          else{
            Get.snackbar("Error", "Something went wrong. Try again.");
          }
        },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials =await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null? true:false;
  }



  Future<void> createUserwithEmailandPassword(String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const DashBoard()) : Get
          .offAll(() => const SplashScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignupWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> sendEmailVarification() async{
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on Exception catch (e) {

    }
  }

  Future<void> loginwithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const DashBoard()) : Get
          .offAll(() => const SplashScreen());
    } on FirebaseAuthException catch (e) {} catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
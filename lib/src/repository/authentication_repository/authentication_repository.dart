import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/mail_verification/mail_verification_Screen.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:fyp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:fyp/src/exceptions/g_exceptions.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/authentication/screens/nav_bar/nav_bar.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  final deviceStorage =GetStorage();
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  var verificationId = ' '.obs;

  User? get firebaseUser => _firebaseUser.value;

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
    // ever(firebaseUser, _setInitialScreen);
  }

  screenRedirect() async{
   deviceStorage.writeIfNull('isFirstTime', false);
   deviceStorage.read('isFirstTime')!=false?Get.offAll(()=>const Welcome(),transition: Transition.fadeIn):Get.offAll(()=>const OnBoardingScreen());
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SplashScreen())
        : user.emailVerified
            ? Get.offAll(() => const NavBar())
            : Get.offAll(() => const MailVerification());
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = GExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = GExceptions();
      throw ex.message;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
// Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = GExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = GExceptions();
      throw ex.message;
    }
  }

  Future<void> phoneAuthentication(String phoneno) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneno,
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == "invalid-phone-number") {
          Get.snackbar("Error", "The provided phone number is not valid.");
        } else {
          Get.snackbar("Error", "Something went wrong. Try again.");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserwithEmailandPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseUser.value != null
          ? Get.offAll(() => const NavBar())
          : Get.offAll(() => SplashScreen());
    }  on FirebaseAuthException catch(e){
      final ex= GExceptions.fromCode(e.code);
      throw e.message!;
    }catch(_){
      const ex = GExceptions();
      throw ex.message;
    }
  }

  Future<void> loginwithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firebaseUser.value != null
          ? Get.offAll(() => const NavBar())
          : Get.offAll(() => SplashScreen());
    } on FirebaseAuthException catch(e){
      final ex= GExceptions.fromCode(e.code);
      throw e.message!;
    }catch(_){
      const ex = GExceptions();
      throw ex.message;
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const Welcome());
    }on FirebaseAuthException catch(e){
      final ex= GExceptions.fromCode(e.code);
      throw e.message!;
    }catch(_){
      const ex = GExceptions();
      throw ex.message;
    }
  }
}

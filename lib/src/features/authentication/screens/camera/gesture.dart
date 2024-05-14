import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_preference.dart';
import 'package:fyp/src/features/authentication/screens/operations/volume.dart';
import 'package:fyp/src/features/authentication/screens/library/library.dart';


class Gestures {
  var channel = const MethodChannel("gesturely");

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  showToast(String message) {
    channel.invokeMethod("showToast", {"message": message});
  }
  startDefaultPlayer(){
    channel.invokeMethod("startDefaultMediaPlayer");
  }

  scrollScreen() {
    channel.invokeMethod("scrollScreen");
  }

  increaseBrightness() {
    channel.invokeMethod("increaseBrightness", {"level": 50});
  }

  decreaseBrightness() {
    channel.invokeMethod("decreaseBrightness", {"level": 50});
  }

  whatsappmsg() {
    // String phoneNumber = "03044555450";
    // String message = "Hello from the other side";

    channel.invokeMethod('openWhatsAppAndSendMessage', {
      'phNo': whatsappPhoneNumber,
      'msg': whatsappMessage,
    });
  }

  callOne() {
    // String phoneNumber = "03044555450";
    channel.invokeMethod("callOne", {"phNo": phoneNumber});
  }

  swipeLTR() {
    channel.invokeMethod("swipeLTR");
  }
  volumeUp(){
    VolumeController.increaseVolume();
  }
  volumeDown(){
    VolumeController.decreaseVolume();
  }
  goBack() {
    navigatorKey.currentState?.pop();
  }

  void perform(GestureAction action) {
    FunctionType preference = GesturePreferences.getPreference(action);

    switch (preference) {
      case FunctionType.increaseBrightness:
        increaseBrightness();
        break;
      case FunctionType.decreaseBrightness:
        decreaseBrightness();
        break;
      case FunctionType.whatsappmsg:
        whatsappmsg();
        break;
      case FunctionType.callOne:
        callOne();
        break;
    // case FunctionType.showToast:
    //   showToast(action.toString());
    //   break;
    // case FunctionType.scrollScreen:
    //   scrollScreen();
    //   break;
      // case FunctionType.swipeLTR:
      //   swipeLTR();
      //   break;
      case FunctionType.unknown:
        debugPrint("Unknown action");
        break;
      case FunctionType.volumeUp:
        volumeUp();
        break;
      case FunctionType.volumeDown:
        volumeDown();
        break;
      case FunctionType.goBack:
        goBack();
        break;
      case FunctionType.startDefaultMediaPlayer:
        startDefaultPlayer();
        break;
      case FunctionType.audioPlay:
        break;
      default:
        print("nothing");
        // TODO: Handle this case.
    }
  }

}

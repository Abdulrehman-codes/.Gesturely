import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_preference.dart';

class Gestures {
  var channel = const MethodChannel("gesturely");


  showToast(String message) {
    channel.invokeMethod("showToast", {"message": message});
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
    String phoneNumber = "03044555450";
    String message = "Hello from the other side";

    channel.invokeMethod('openWhatsAppAndSendMessage', {
      'phNo': phoneNumber,
      'msg': message,
    });
  }

  callOne() {
    String phoneNumber = "03044555450";
    channel.invokeMethod("callOne", {"phNo": phoneNumber});
  }

  swipeLTR() {
    channel.invokeMethod("swipeLTR");
  }

  void perform(GestureAction action) {
    FunctionType preference = GesturePreferences.getPreference(action);

    switch (preference) {
      case FunctionType.showToast:
        showToast(action.toString());
        break;
      case FunctionType.scrollScreen:
        scrollScreen();
        break;
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
      case FunctionType.swipeLTR:
        swipeLTR();
        break;
      case FunctionType.unknown:
        debugPrint("Unknown action");
        break;
    }
  }

}
import 'package:flutter/services.dart';


enum GestureAction {
  call,
  dislike,
  four,
  like,
  mute,
  ok,
  one,
  fist,
  peace,
  peace_inverted,
  rock,
  stop,
  stop_inverted,
  three2,
  two_up,
  two_up_inverted,
  palm,
  no_gesture,
}

enum FunctionType {
  showToast,
  scrollScreen,
  increaseBrightness,
  decreaseBrightness,
  whatsappmsg,
  callOne,
  swipeLTR,
  unknown,
}

GestureAction? getGestureActionFromTag(String tag) {
  switch (tag) {
    case "call":
      return GestureAction.call;
    case "dislike":
      return GestureAction.dislike;
    case "four":
      return GestureAction.four;
  // ... add cases for other gesture tags
    default:
      return null;
  }
}

var channel = const MethodChannel("gesturely");
showToast(String message) {
  channel.invokeMethod("showToast", {"message": message});
}

scrollScreen() {
  channel.invokeMethod("scrollScreen"); // Provide the offset value here
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
  // else{
  //   showToast("Permission Not Granted");
  // }
}

swipeLTR() {
  channel.invokeMethod("swipeLTR");
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fyp/src/features/authentication/screens/operations/volume.dart';
import 'package:fyp/src/features/authentication/screens/library/library.dart';

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
  volumeUp,
  volumeDown,
  increaseBrightness,
  decreaseBrightness,
  whatsappmsg,
  callOne,
  goBack,
  startDefaultMediaPlayer,
  audioPlay,
  unknown

}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var channel = const MethodChannel("gesturely");
showToast(String message) {
  channel.invokeMethod("showToast", {"message": message});
}

scrollScreen() {
  channel.invokeMethod("scrollScreen");
}

increaseBrightness() {
  showToast("Increasing Brightness by 10");
  channel.invokeMethod("increaseBrightness", {"level": 50});
}

decreaseBrightness() {
  showToast("Decreasing Brightness by 10");
  channel.invokeMethod("decreaseBrightness", {"level": 50});
}

whatsappmsg() {
  String phoneNumber = "03044555450";
  String message = "Hello from the other side";

  channel.invokeMethod('openWhatsAppAndSendMessage', {
    'phNo': whatsappPhoneNumber,
    'msg': whatsappMessage,
  });
}

callOne() {
  // String phoneNumber = "03044555450";
  channel.invokeMethod("callOne", {"phNo": phoneNumber});

}

volumeUp(){
  showToast("Increasing Volume by 10");
  VolumeController.increaseVolume();
}
volumeDown(){
  showToast("Decreasing Volume by 10");
  VolumeController.decreaseVolume();
}

swipeLTR() {
  channel.invokeMethod("swipeLTR");
}
goBack() {
  navigatorKey.currentState?.pop();
}
startDefaultPlayer(){
  channel.invokeMethod("startDefaultMediaPlayer");
}

audioPlay(){
  print("jabba");
  print(audioFilePath);
  channel.invokeMethod("audioPlay",{"filePath": audioFilePath});
}
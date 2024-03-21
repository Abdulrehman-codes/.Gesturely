import 'package:flutter/services.dart';

class ScreenScroll {
  static const MethodChannel _channel = MethodChannel('com.example.fyp/screen_scroll');

  static Future<void> scrollScreen() async {
    try {
      await _channel.invokeMethod('scrollScreen');
    } on PlatformException catch (e) {
      print("Failed to scroll screen: $e");
    }
  }

  static Future<void> scrollUp() async {
    try {
      await _channel.invokeMethod('scrollUp');
    } on PlatformException catch (e) {
      print("Failed to scroll up: $e");
    }
  }

  static Future<void> scrollDown() async {
    try {
      await _channel.invokeMethod('scrollDown');
    } on PlatformException catch (e) {
      print("Failed to scroll down: $e");
    }
  }
}

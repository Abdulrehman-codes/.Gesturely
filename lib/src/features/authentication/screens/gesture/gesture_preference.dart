import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';

class GesturePreferences {
  static final Map<GestureAction, FunctionType> _preferences = {};

  static void setPreference(GestureAction gesture, FunctionType action) {
    _preferences[gesture] = action;
  }

  static FunctionType getPreference(GestureAction gesture) {
    return _preferences[gesture] ?? FunctionType.unknown;
  }
}
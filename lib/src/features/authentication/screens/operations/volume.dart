import 'package:perfect_volume_control/perfect_volume_control.dart';

class VolumeController {
  static double currentVolume = 0.5;

  static void initializeVolume() {
    PerfectVolumeControl.hideUI = false;
    PerfectVolumeControl.getVolume().then((volume) {
      currentVolume = volume;
    });

    PerfectVolumeControl.stream.listen((volume) {
      currentVolume = volume;
    });
  }

  static void increaseVolume() {
    if (currentVolume < 1.0) {
      currentVolume += 0.1;
      if (currentVolume > 1.0) {
        currentVolume = 1.0;
      }
      PerfectVolumeControl.setVolume(currentVolume);
    }
  }

  static void decreaseVolume() {
    if (currentVolume > 0.0) {
      currentVolume -= 0.1;
      if (currentVolume < 0.0) {
        currentVolume = 0.0;
      }
      PerfectVolumeControl.setVolume(currentVolume);
    }
  }
}

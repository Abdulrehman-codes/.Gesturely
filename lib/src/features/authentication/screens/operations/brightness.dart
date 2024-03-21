import 'package:flutter/material.dart';
import 'package:screen_brightness_util/screen_brightness_util.dart';

class BrightnessScreen extends StatefulWidget {
  @override
  _BrightnessScreenState createState() => _BrightnessScreenState();
}

class _BrightnessScreenState extends State<BrightnessScreen> {
  final ScreenBrightnessUtil _screenBrightnessUtil = ScreenBrightnessUtil();
  double currentBrightness = 0.5;

  @override
  void initState() {
    super.initState();
    _getCurrentBrightness();
  }

  Future<void> _getCurrentBrightness() async {
    double brightness = await _screenBrightnessUtil.getBrightness();
    setState(() {
      currentBrightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brightness Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Brightness: ${currentBrightness.toStringAsFixed(2)}',
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    increaseBrightness(); // Call the public method to increase brightness
                  },
                  child: Text('Increase Brightness'),
                ),
                ElevatedButton(
                  onPressed: () {
                    decreaseBrightness();
                  },
                  child: Text('Decrease Brightness'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> increaseBrightness() async {
    double brightness = currentBrightness + 0.1;
    if (brightness <= 1.0) {
      await _screenBrightnessUtil.setBrightness(brightness);
      setState(() {
        currentBrightness = brightness;
      });
    }
  }

  Future<void> decreaseBrightness() async {
    double brightness = currentBrightness - 0.1;
    if (brightness >= 0.0) {
      await _screenBrightnessUtil.setBrightness(brightness);
      setState(() {
        currentBrightness = brightness;
      });
    }
  }
}

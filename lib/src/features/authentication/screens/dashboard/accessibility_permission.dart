import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';

void openAccessibilitySettings() {
  AndroidIntent intent = AndroidIntent(
    action: 'android.settings.ACCESSIBILITY_SETTINGS',
  );
  intent.launch();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accessibility Settings Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accessibility Settings Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: openAccessibilitySettings,
            child: Text('Open Accessibility Settings'),
          ),
        ),
      ),
    );
  }
}

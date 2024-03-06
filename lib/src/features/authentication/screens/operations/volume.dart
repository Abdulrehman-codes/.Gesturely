import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Volume(),
    );
  }
}

class Volume extends StatefulWidget {
  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {

  double currentvol = 0.5;

  @override
  void initState() {
    PerfectVolumeControl.hideUI = false; //set if system UI is hidden or not on volume up/down
    Future.delayed(Duration.zero,() async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Increase/Decrease Volume in Flutter"),
        backgroundColor: Colors.redAccent,
      ),

      body: Container(
        margin: EdgeInsets.only(top:100),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Current Volume: ${currentvol.clamp(0, 1)}"), // Clamp the volume value to stay within the range of 0 to 1
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentvol < 1.0) {
                        currentvol = (currentvol + 0.1).clamp(0, 1); // Clamp the new volume value
                        PerfectVolumeControl.setVolume(currentvol);
                      }
                    });
                  },
                  child: Text("Increase"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentvol > 0.0) {
                        currentvol = (currentvol - 0.1).clamp(0, 1); // Clamp the new volume value
                        PerfectVolumeControl.setVolume(currentvol);
                      }
                    });
                  },
                  child: Text("Decrease"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_preference.dart';

class GesturePreferencesScreen extends StatefulWidget {
  @override
  _GesturePreferencesScreenState createState() => _GesturePreferencesScreenState();
}

class _GesturePreferencesScreenState extends State<GesturePreferencesScreen> {
  GestureAction? _selectedGesture;
  FunctionType? _selectedAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Preferences'),
      ),
      body: Column(
        children: [
          // Display available gestures and allow user to select one
          Row(
            children: [
              Expanded(
                child: DropdownButton<GestureAction>(
                  value: _selectedGesture,
                  hint: Text('Select a gesture'),
                  onChanged: (GestureAction? value) {
                    setState(() {
                      _selectedGesture = value;
                    });
                  },
                  items: GestureAction.values.map((GestureAction gesture) {
                    return DropdownMenuItem<GestureAction>(
                      value: gesture,
                      child: Text(gesture.toString()),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),

          // Display available actions and allow user to select one
          Row(
            children: [
              Expanded(
                child: DropdownButton<FunctionType>(
                  value: _selectedAction,
                  hint: Text('Select an action'),
                  onChanged: (FunctionType? value) {
                    setState(() {
                      _selectedAction = value;
                    });
                  },
                  items: FunctionType.values.map((FunctionType action) {
                    return DropdownMenuItem<FunctionType>(
                      value: action,
                      child: Text(action.toString()),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
          ElevatedButton(
            onPressed: _selectedAction != null
                ? () {

            }
                : null,
            child: Text('Confirm'),
          ),
          // Save the user's preference
          // ElevatedButton(
          //   onPressed: _selectedGesture != null && _selectedAction != null
          //       ? () {
          //     GesturePreferences.setPreference(
          //       _selectedGesture!,
          //       _selectedAction!,
          //     );
          //   }
          //       : null,
          //   child: Text('Save Preference'),
          // ),
        ],
      ),
    );
  }
}

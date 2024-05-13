import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/camera/gesture_enum.dart';
import 'package:fyp/src/features/authentication/screens/gesture/gesture_preference.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library>
    with AutomaticKeepAliveClientMixin<Library> {
  // Add the next gesture card to the list
  List<Widget> cards = [];
  List<String> gestureNames = [
    'call',
    'dislike',
    'fist',
    'four',
    'like',
    'mute',
    'ok',
    'one',
    'palm',
    'peace'
  ];

  // Map to store user's gesture preferences
  Map<String, FunctionType> gesturePreferences = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    generateCards();
  }

  void generateCards() {
    for (int i = 0; i < gestureNames.length; i++) {
      cards.add(
        GestureDetector(
          onTap: () {
            _showCardDetailsBottomSheet(i);
          },
          child: Card(
            color: Color(0xff9a83e5).withOpacity(0.8),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const ClipRRect(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.front_hand),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    "     ${gestureNames[i].toUpperCase()}",
                    style: TextStyle(
                      color: Colors.white, // Change the color of the text
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showCardDetailsBottomSheet(int index) {
    String gestureName = gestureNames[index];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return SingleChildScrollView(
          child: Container(
            width: width,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${gestureName.capitalize()} Details',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  gestureName.capitalize(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gesture Data ${gestureName.capitalize()}',
                  style: const TextStyle(height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                _buildActionButtons(gestureName),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Show gesture preference screen
                    _showGesturePreferenceScreen(gestureName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Button border radius
                    ),
                    textStyle: TextStyle(
                      fontSize: 16, // Text font size
                    ),
                  ),
                  child: const Text('Set Gesture Preference'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(String gestureName) {
    FunctionType? actionPreference = gesturePreferences[gestureName];
    print('Action Preference: $actionPreference');

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            actionPreference != null
                ? actionPreference.toString()
                : 'No Action Assigned',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        // Add other action buttons here
      ],
    );
  }

  void _showGesturePreferenceScreen(String gestureName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GesturePreferencesScreen(
          gestureName: gestureName,
          onPreferenceSaved: (selectedAction) {
            if (selectedAction != null) {
              gesturePreferences[gestureName] = selectedAction;
              print(selectedAction);
              setState(() {
                gesturePreferences[gestureName] = selectedAction;
              }); // Update the UI if necessary
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the app bar shadow
        title: Text(
          'Library',
          style: TextStyle(
            color: Colors.white, // Change the app bar title color
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background image with blur effect and color layer
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xff38027a).withOpacity(0.8), // Adjust the color and opacity
                BlendMode.color, // Change the blend mode if needed
              ),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Adjust blur intensity
                child: Image.asset(
                  gDashboard,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 16), // Add space for the app bar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: cards.isNotEmpty
                        ? cards
                        : [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No cards added yet.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Change the text color for better visibility
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GesturePreferencesScreen extends StatefulWidget {
  final String gestureName;
  final Function(FunctionType?) onPreferenceSaved;

  GesturePreferencesScreen({
    required this.gestureName,
    required this.onPreferenceSaved,
  });

  @override
  _GesturePreferencesScreenState createState() =>
      _GesturePreferencesScreenState();
}

class _GesturePreferencesScreenState extends State<GesturePreferencesScreen> {
  GestureAction? _selectedGesture;
  FunctionType? _selectedAction;

  @override
  void initState() {
    super.initState();
    _selectedGesture = _mapStringToGestureAction(widget.gestureName);
  }

  GestureAction _mapStringToGestureAction(String gestureName) {
    switch (gestureName) {
      case 'call':
        return GestureAction.call;
      case 'dislike':
        return GestureAction.dislike;
      case 'fist':
        return GestureAction.fist;
      case 'four':
        return GestureAction.four;
      case 'like':
        return GestureAction.like;
      case 'mute':
        return GestureAction.mute;
      case 'ok':
        return GestureAction.ok;
      case 'one':
        return GestureAction.one;
      case 'palm':
        return GestureAction.palm;
      case 'peace':
        return GestureAction.peace;
      default:
        return GestureAction.no_gesture;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Preferences'),
      ),
      body: Column(
        children: [
          // Display available actions and allow user to select one
          DropdownButton<FunctionType>(
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

          // Save the user's preference
          ElevatedButton(
            onPressed: _selectedAction != null
                ? () {
              GesturePreferences.setPreference(
                _selectedGesture!,
                _selectedAction!,
              );
              widget.onPreferenceSaved(_selectedAction);
              Navigator.pop(context);
              showToast(
                  "Command ${_selectedAction.toString()} set Successfully");
              showToast("Command Saved Successfully");
            }
                : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Background color
              onPrimary: Colors.white, // Text color
              padding:
              EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8), // Button border radius
              ),
              textStyle: TextStyle(
                fontSize: 16, // Text font size
              ),
            ),
            child: Text('Save Preference'),
          ),
        ],
      ),
    );
  }
}

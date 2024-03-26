import 'package:flutter/material.dart';

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
            color: Colors.grey,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: ClipRRect(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.front_hand),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    "     ${gestureNames[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
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
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${gestureName.capitalize()} Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${gestureName.capitalize()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gesture Data ${gestureName.capitalize()}',
                  style: TextStyle(height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Volume Up button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Volume Up',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Volume Down button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Volume Down',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Brightness Up button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Brightness Up',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Brightness Down button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Brightness Down',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Scroll Up button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Scroll Up',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Scroll Down button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set button color to transparent
                    ),
                    child: Text(
                      'Scroll Down',
                      style: TextStyle(color: Colors.black), // Set text color to black
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Library'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: cards.isNotEmpty
              ? cards
              : [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'No cards added yet.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
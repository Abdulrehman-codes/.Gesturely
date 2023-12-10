import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Placeholder for your user cards or loading indicator
            Card(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.front_hand),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      "Gesture Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                subtitle: Text(
                  "Gesture Data",
                  style: TextStyle(height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

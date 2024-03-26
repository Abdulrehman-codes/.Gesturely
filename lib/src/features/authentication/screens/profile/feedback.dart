import 'package:flutter/material.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:wiredash/wiredash.dart';



class FeedBack extends StatelessWidget {
  const FeedBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      secret: secret,
      projectId: projectId,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Wiredash.of(context).show();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
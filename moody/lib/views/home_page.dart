import 'package:flutter/material.dart';
import 'package:moody/views/new_mood_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _newMood() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewMoodPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("HOME PAGE"),
            FlatButton(
              child: Text("New mood"),
              onPressed: () => _newMood(),
            ),
          ],
        ),
      ),
    );
  }
}
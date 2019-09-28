import 'package:flutter/material.dart';
import 'package:moody/views/summary_page.dart';

class NewMoodPage extends StatefulWidget {
  @override
  _NewMoodPageState createState() => _NewMoodPageState();
}

class _NewMoodPageState extends State<NewMoodPage> {

  _summary() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("NEW MOOD PAGE"),
            FlatButton(
              child: Text("New mood"),
              onPressed: () => _summary(),
            ),
          ],
        ),
      ),
    );
  }
}
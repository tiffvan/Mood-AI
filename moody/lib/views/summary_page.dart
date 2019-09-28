import 'package:flutter/material.dart';
import 'package:moody/views/home_page.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  _home() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SUMMARY PAGE"),
            FlatButton(
              child: Text("Home"),
              onPressed: () => _home(),
            ),
          ],
        ),
      ),
    );
  }
}
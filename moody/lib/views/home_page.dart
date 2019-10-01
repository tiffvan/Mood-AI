import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radial_button/widget/circle_floating_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> fabButtons;
  GlobalKey<CircleFloatingButtonState> key = GlobalKey<CircleFloatingButtonState>();
//  File _image;
//
//  _getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//    });
//  }

  @override
  void initState() {
    fabButtons = [
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.amberAccent,
        onPressed: null,
        child: Icon(Icons.camera_alt, color: Colors.pink[900]),
        tooltip: "Camera",
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.amberAccent,
//        onPressed: _getImage(),
      onPressed: null,
        child: Icon(Icons.image, color: Colors.pink[900]),
        tooltip: "Gallery",
      ),
    ];
    super.initState();
  }

  _content() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.amberAccent),
              onPressed: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Text("Moody", style: TextStyle(color: Colors.amberAccent, fontSize: 45.0, fontFamily: 'QuicksandB')),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: Text("xxx xxx xxx xxx xxx xxx xxx xxx"),
          ),
//          _image == null ? Text('No image selected.') : Image.file(_image),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.pink[900],
              Colors.purple[900],
              Colors.purple[800],
              Colors.blue[800],
            ],
          ),
        ),
        child: _content(),
      ),
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        key: key,
        items: fabButtons,
        color: Colors.pink[900],
        icon: Icons.mood,
        duration: Duration(milliseconds: 800),
        curveAnim: Curves.ease,
      ),
    );
  }
}

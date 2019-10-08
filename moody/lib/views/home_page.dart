import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moody/views/help-screens.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:mlkit/mlkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage({Key key, this.title}) : super(key: key);

  final String title;
}

class _HomePageState extends State<HomePage> {
  List<Widget> fabButtons;
  GlobalKey<CircleFloatingButtonState> key = GlobalKey<CircleFloatingButtonState>();

  File _file;

  List<VisionFace> _face = <VisionFace>[];

  VisionFaceDetectorOptions options = new VisionFaceDetectorOptions(modeType: VisionFaceDetectorMode.Accurate, landmarkType: VisionFaceDetectorLandmark.All, classificationType: VisionFaceDetectorClassification.All, minFaceSize: 0.15, isTrackingEnabled: true);

  FirebaseVisionFaceDetector detector = FirebaseVisionFaceDetector.instance;

  @override
  void initState() {
    fabButtons = [
      FloatingActionButton(
          heroTag: UniqueKey(),
          backgroundColor: Colors.amberAccent,
          child: Icon(Icons.camera_alt, color: Colors.pink[900]),
          tooltip: "Camera",
          onPressed: () async {
            var file = await ImagePicker.pickImage(source: ImageSource.camera);
            setState(
              () {
                _file = file;
              },
            );

            var face = await detector.detectFromBinary(_file?.readAsBytesSync(), options);
            setState(() {
              if (face.isEmpty) {
                print('No face detected');
              } else {
                _face = face;
              }
            });
          }),
      FloatingActionButton(
          heroTag: UniqueKey(),
          backgroundColor: Colors.amberAccent,
          tooltip: "Gallery",
          child: Icon(Icons.image, color: Colors.pink[900]),
          onPressed: () async {
            var file = await ImagePicker.pickImage(source: ImageSource.gallery);
            setState(
              () {
                _file = file;
              },
            );

            var face = await detector.detectFromBinary(_file?.readAsBytesSync(), options);
            setState(() {
              if (face.isEmpty) {
                print('No face detected');
              } else {
                _face = face;
              }
            });
          }),
    ];
    super.initState();
  }

  _buildImage() {
    return SizedBox(
      height: 400.0,
      child: Center(
        child: _file == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Please use the button at the bottom to pick an image from either the gallery or camera',
                    style: TextStyle(color: Colors.amberAccent, fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
//                  Tab(icon: Image.asset("assets/images/arrow1.png", height: 100.0)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
                    child: Image(image: AssetImage("assets/images/arrow1.png")),
                  ),
                ],
              )
            : FutureBuilder<Size>(
                future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(child: Image.file(_file, fit: BoxFit.fitWidth));
                  } else {
                    return Text('Please wait...');
                  }
                },
              ),
      ),
    );
  }

  _content() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(Icons.info_outline, color: Colors.amberAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpScreens(),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text("Moody", style: TextStyle(color: Colors.amberAccent, fontSize: 45.0, fontFamily: 'QuicksandB')),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: _buildImage(),
            ),
          ),
          _showSmileProb(_face),
          _moodGuess(_face),
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

Future _getImageSize(Image image) {
  Completer<Size> completer = new Completer<Size>();
  image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool _) => completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()))));
  return completer.future;
}

_showSmileProb(List<VisionFace> faceList) {
  if (faceList == null || faceList.length == 0) {
    return Text('', textAlign: TextAlign.center);
  }
  return Container(
    child: Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Smile probability: ${faceList[0].smilingProbability}",
          style: TextStyle(color: Colors.amberAccent),
        ),
      ),
    ),
  );
}

_moodGuess(List<VisionFace> faceList) {
  if (faceList == null || faceList.length == 0) {
    return Text('', textAlign: TextAlign.center);
  } else if (faceList[0].smilingProbability >= 0.5) {
    return Expanded(
      child: Column(children: <Widget>[
        Text("Mood: Happy", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
        Text("Quote", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
        Text("Lorem ipsum HAPPY quote", style: TextStyle(color: Colors.amberAccent)),
        Text("Songs", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
        Text("Lorem ipsum\nLorem ipsum\nLorem ipsum", style: TextStyle(color: Colors.amberAccent)),
      ]),
    );
  } else if (faceList[0].smilingProbability < 0.5) {
    return Column(children: <Widget>[
      Text("Mood: Sad", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
      Text("Quote", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
      Text("Lorem ipsum SAD quote", style: TextStyle(color: Colors.amberAccent)),
      Text("Songs", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
      Text("Lorem ipsum\nLorem ipsum\nLorem ipsum", style: TextStyle(color: Colors.amberAccent)),
    ]);
  }
}

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moody/views/help-screens.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:mlkit/mlkit.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage({Key key, this.title}) : super(key: key);

  final String title;
}

class _HomePageState extends State<HomePage> {
  List<Widget> fabButtons;
  GlobalKey<CircleFloatingButtonState> key = GlobalKey<CircleFloatingButtonState>();
  TextEditingController textEditingControllerUrl = new TextEditingController();
  TextEditingController textEditingControllerId = new TextEditingController();

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
        },
      ),
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
        },
      ),
    ];
    super.initState();
  }

  _buildImage() {
    return SizedBox(
      height: 350.0,
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
                icon: Icon(Icons.info_outline, color: Colors.pink[900]),
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
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text("Be Happy!", style: TextStyle(color: Colors.amberAccent, fontSize: 45.0, fontFamily: 'QuicksandB')),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: _buildImage(),
            ),
          ),
//          _showSmileProb(_face),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: _moodGuess(_face),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      body: Container(
        alignment: Alignment.center,
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

  Future _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool _) => completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()))));
    return completer.future;
  }

  _showSmileProb(List<VisionFace> faceList) {
    if (faceList == null || faceList.length == 0) {
      return Text('', textAlign: TextAlign.center);
    }
    return Container(
      child: Text(
        "Smile probability: ${faceList[0].smilingProbability}",
        style: TextStyle(color: Colors.amberAccent),
      ),
    );
  }

  _moodGuess(List<VisionFace> faceList) {
    if (faceList == null || faceList.length == 0) {
      return Text('', textAlign: TextAlign.center);
    } else if (faceList[0].smilingProbability >= 0.5) {
      //YOUTUBE
      void playYoutubeVideo() {
        FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyDWJLD1b_G7IJtmzxq1jQtfh0pLXd1rnx4",
          videoUrl: "https://www.youtube.com/watch?v=ZbZSe6N_BXs",
        );
      }
      void playYoutubeURL() {
        FlutterYoutube.onVideoEnded.listen((onData) {
          //perform your action when video playing is done
        });
        FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyDWJLD1b_G7IJtmzxq1jQtfh0pLXd1rnx4",
          videoUrl: textEditingControllerUrl.text,
          autoPlay: true,
        );
      }
      return Column(children: <Widget>[
        Text("You are HAPPY!", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 22.0)),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: GradientButton(
            child: Text('Play a lekker song!', style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
            increaseWidthBy: 100.0,
            increaseHeightBy: 20.0,
            callback: playYoutubeVideo,
            gradient: Gradients.blush,
            shadowColor: Gradients.blush.colors.last.withOpacity(0.25),
          ),
        ),
      ]);
    } else if (faceList[0].smilingProbability < 0.5) {
      //YOUTUBE
      void playYoutubeVideo() {
        FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyDWJLD1b_G7IJtmzxq1jQtfh0pLXd1rnx4",
          videoUrl: "https://www.youtube.com/watch?v=EtH9Yllzjcc",
        );
      }
      void playYoutubeURL() {
        FlutterYoutube.onVideoEnded.listen((onData) {
          //perform your action when video playing is done
        });
        FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyDWJLD1b_G7IJtmzxq1jQtfh0pLXd1rnx4",
          videoUrl: textEditingControllerUrl.text,
          autoPlay: true,
        );
      }
      return Column(children: <Widget>[
        Text("You are SAD!", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 22.0)),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: GradientButton(
            child: Text('Lets get happy!', style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
            increaseWidthBy: 100.0,
            increaseHeightBy: 20.0,
            callback: playYoutubeVideo,
            gradient: Gradients.tameer,
            shadowColor: Gradients.blush.colors.last.withOpacity(0.25),
          ),
        ),
      ]);
    }
  }
}

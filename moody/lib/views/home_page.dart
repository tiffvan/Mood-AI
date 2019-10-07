import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

//  File _image;
  File _file;

  List<VisionFace> _face = <VisionFace>[];

  VisionFaceDetectorOptions options = new VisionFaceDetectorOptions(modeType: VisionFaceDetectorMode.Accurate, landmarkType: VisionFaceDetectorLandmark.All, classificationType: VisionFaceDetectorClassification.All, minFaceSize: 0.15, isTrackingEnabled: true);

  FirebaseVisionFaceDetector detector = FirebaseVisionFaceDetector.instance;

//  Future getImageFromCam() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      _image = image;
//    });
//  }
//
//  Future getImageFromGallery() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
          child: Icon(Icons.camera_alt, color: Colors.pink[900]),
          tooltip: "Camera",
//        onPressed: getImageFromCam,
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
//        onPressed: getImageFromGallery,
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

//  Widget showBody(File file) {
//    return new Container(
//      child: new Stack(
//        children: <Widget>[
////          _buildImage(),
//          _showDetails(_face),
//        ],
//      ),
//    );
//  }

  Widget _buildImage() {
    return new SizedBox(
      height: 300.0,
      child: new Center(
        child: _file == null
            ? new Text('Select image using floating button...', style: TextStyle(color: Colors.amberAccent),)
            : new FutureBuilder<Size>(
                future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(foregroundDecoration: TextDetectDecoration(_face, snapshot.data), child: Image.file(_file, fit: BoxFit.fitWidth));
                  } else {
                    return new Text('Please wait...');
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
              onPressed: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text("Moody", style: TextStyle(color: Colors.amberAccent, fontSize: 45.0, fontFamily: 'QuicksandB')),
          ),
//          Padding(
//            padding: EdgeInsets.only(left: 8.0, right: 8.0),
//            child: AspectRatio(
//              aspectRatio: 1 / 1,
//              child: Container(
//                alignment: Alignment.center,
//                height: 300,
//                width: 300,
//                color: Colors.teal,
//                child: _image == null ? Text('No image selected.') : Image.file(_image),
//              ),
//            ),
//          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: _buildImage(),
            ),
          ),
          _showDetails(_face),
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

class TextDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<VisionFace> _texts;

  TextDetectDecoration(List<VisionFace> texts, Size originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _TextDetectPainter(_texts, _originalImageSize);
  }
}

Future _getImageSize(Image image) {
  Completer<Size> completer = new Completer<Size>();
//  image.image.resolve(new ImageConfiguration()).addListener(
//          (ImageInfo info, bool _) => completer.complete(
//          Size(info.image.width.toDouble(), info.image.height.toDouble())));
  image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool _) => completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()))));
  return completer.future;
}

Widget _showDetails(List<VisionFace> faceList) {
  if (faceList == null || faceList.length == 0) {
    return new Text('', textAlign: TextAlign.center);
  }
  return new Container(
    child: Expanded(
      child: new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: faceList.length,
        itemBuilder: (context, i) {
          checkData(faceList);
          return _buildRow(faceList[0].hasLeftEyeOpenProbability, faceList[0].headEulerAngleY, faceList[0].headEulerAngleZ, faceList[0].leftEyeOpenProbability, faceList[0].rightEyeOpenProbability, faceList[0].smilingProbability, faceList[0].trackingID);
        },
      ),
    ),
  );
}

//For checking and printing different variables from Firebase
void checkData(List<VisionFace> faceList) {
  final double uncomputedProb = -1.0;
  final int uncompProb = -1;

  for (int i = 0; i < faceList.length; i++) {
    Rect bounds = faceList[i].rect;
    print('Rectangle : $bounds');

    VisionFaceLandmark landmark = faceList[i].getLandmark(FaceLandmarkType.LeftEar);

    if (landmark != null) {
      VisionPoint leftEarPos = landmark.position;
      print('Left Ear Pos : $leftEarPos');
    }

    if (faceList[i].smilingProbability != uncomputedProb) {
      double smileProb = faceList[i].smilingProbability;
      print('Smile Prob : $smileProb');
    }

    if (faceList[i].rightEyeOpenProbability != uncomputedProb) {
      double rightEyeOpenProb = faceList[i].rightEyeOpenProbability;
      print('RightEye Open Prob : $rightEyeOpenProb');
    }

    if (faceList[i].trackingID != uncompProb) {
      int tID = faceList[i].trackingID;
      print('Tracking ID : $tID');
    }
  }
}

/*
    HeadEulerY : Head is rotated to right by headEulerY degrees
    HeadEulerZ : Head is tilted sideways by headEulerZ degrees
    LeftEyeOpenProbability : left Eye Open Probability
    RightEyeOpenProbability : right Eye Open Probability
    SmilingProbability : Smiling probability
    Tracking ID : If face tracking is enabled
  */
Widget _buildRow(bool leftEyeProb, double headEulerY, double headEulerZ, double leftEyeOpenProbability, double rightEyeOpenProbability, double smileProb, int tID) {
  return ListTile(
    title: new Text(
      "\nLeftEyeProb: $leftEyeProb \nHeadEulerY : $headEulerY \nHeadEulerZ : $headEulerZ \nLeftEyeOpenProbability : $leftEyeOpenProbability \nRightEyeOpenProbability : $rightEyeOpenProbability \nSmileProb : $smileProb \nFaceTrackingEnabled : $tID",
    ),
    dense: true,
  );
}

class _TextDetectPainter extends BoxPainter {
  final List<VisionFace> _faceLabels;
  final Size _originalImageSize;

  _TextDetectPainter(faceLabels, originalImageSize)
      : _faceLabels = faceLabels,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = new Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final _heightRatio = _originalImageSize.height / configuration.size.height;
    final _widthRatio = _originalImageSize.width / configuration.size.width;
    for (var faceLabel in _faceLabels) {
      final _rect = Rect.fromLTRB(offset.dx + faceLabel.rect.left / _widthRatio, offset.dy + faceLabel.rect.top / _heightRatio, offset.dx + faceLabel.rect.right / _widthRatio, offset.dy + faceLabel.rect.bottom / _heightRatio);

      canvas.drawRect(_rect, paint);
    }
  }
}

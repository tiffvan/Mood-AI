import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:moody/views/home_page.dart';

class HelpScreens extends StatelessWidget {
  final helpPages = [
    PageViewModel(
        pageColor: const Color(0xFF212121),
        bubble: Image.asset('assets/images/yellow.png'),
        body: Text(
          'Be Happy is a fun app that allows you to take your mood from sad to happy in an instant with a cute video! If you\'re happy you\'ll get a cool song!'
        ),
        title: Text(
          'Be Happy',
        ),
        titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
        bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
        mainImage: Image.asset(
          'assets/images/smilePink.png',
          height: 400.0,
          width: 400.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF212121),
      iconImageAssetPath: 'assets/images/yellow.png',
      body: Text(
        'You can either take a picture of yourself with the camera or choose a picture from your gallery',
      ),
      title: Text('Picture options'),
      mainImage: Image.asset(
        'assets/images/buttons.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
      bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
    ),
    PageViewModel(
      pageColor: const Color(0xFF212121),
      iconImageAssetPath: 'assets/images/yellow.png',
      body: Text(
        'You can improve your mood and get a cool video!',
      ),
      title: Text('Why?'),
      mainImage: Image.asset(
        'assets/images/video.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
      bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        helpPages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.amberAccent,
          fontSize: 13.0,
        ),
      ), //IntroViewsFlutter
    ); //Builder
  }
}

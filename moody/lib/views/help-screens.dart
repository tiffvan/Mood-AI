import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:moody/views/home_page.dart';

class HelpScreens extends StatelessWidget {
  final helpPages = [
    PageViewModel(
        pageColor: const Color(0xFF850D52),
        bubble: Image.asset('assets/images/blue.png'),
        body: Text(
          'Moody is a fun app that allows you to have your mood guessed which then gives some music suggestions, based on your mood',
        ),
        title: Text(
          'What is Moody?',
        ),
        titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
        bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
        mainImage: Image.asset(
          'assets/images/pic1.jpg',
          height: 350.0,
          width: 350.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF4B148B),
      iconImageAssetPath: 'assets/images/pink.png',
      body: Text(
        'You can either take a picture of yourself with the camera or choose a picture from your gallery',
      ),
      title: Text('Picture options'),
      mainImage: Image.asset(
        'assets/images/pic2.jpg',
        height: 350.0,
        width: 350.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
      bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
    ),
    PageViewModel(
      pageColor: const Color(0xFF1565C0),
      iconImageAssetPath: 'assets/images/purple.png',
      body: Text(
        'Once you have picked or taken your picture, you will recieve some music suggestions for that mood',
      ),
      title: Text('Why?'),
      mainImage: Image.asset(
        'assets/images/pic3.jpg',
        height: 350.0,
        width: 350.0,
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
          fontSize: 15.0,
        ),
      ), //IntroViewsFlutter
    ); //Builder
  }
}

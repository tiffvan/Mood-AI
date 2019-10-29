import 'package:flutter/material.dart';
import 'package:moody/model/introduction_screen.dart';
import 'package:moody/views/home_page.dart';
import 'package:moody/model/page_decoration.dart';
import 'package:moody/model/page_view_model.dart';
import 'package:moody/helpers/intro_screen.dart';

const kImageDemo = "https://cdn4.iconfinder.com/data/icons/onboarding-material-color/128/__14-512.png";

class HelpScreens extends StatelessWidget {
//  final helpPages = [
//    PageViewModel(
//        pageColor: const Color(0xFF212121),
//        bubble: Image.asset('assets/images/yellow.png'),
//        body: Text(
//          'Be Happy is a fun app that allows you to take your mood from sad to happy in an instant with a cute video! If you\'re happy you\'ll get a cool song!'
//        ),
//        title: Text(
//          'Be Happy',
//        ),
//        titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
//        bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
//        mainImage: Image.asset(
//          'assets/images/smilePink.png',
//          height: 400.0,
//          width: 400.0,
//          alignment: Alignment.center,
//        )),
//    PageViewModel(
//      pageColor: const Color(0xFF212121),
//      iconImageAssetPath: 'assets/images/yellow.png',
//      body: Text(
//        'You can either take a picture of yourself with the camera or choose a picture from your gallery',
//      ),
//      title: Text('Picture options'),
//      mainImage: Image.asset(
//        'assets/images/buttons.png',
//        height: 400.0,
//        width: 400.0,
//        alignment: Alignment.center,
//      ),
//      titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
//      bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
//    ),
//    PageViewModel(
//      pageColor: const Color(0xFF212121),
//      iconImageAssetPath: 'assets/images/yellow.png',
//      body: Text(
//        'You can improve your mood and get a cool video!',
//      ),
//      title: Text('Why?'),
//      mainImage: Image.asset(
//        'assets/images/video.png',
//        height: 400.0,
//        width: 400.0,
//        alignment: Alignment.center,
//      ),
//      titleTextStyle: TextStyle(fontFamily: 'QuicksandB', fontSize: 45.0, color: Colors.amberAccent),
//      bodyTextStyle: TextStyle(fontFamily: 'QuicksandL', fontSize: 20.0, color: Colors.amberAccent),
//    ),
//  ];

//  @override
//  Widget build(BuildContext context) {
//    return Builder(
//      builder: (context) => IntroViewsFlutter(
//        helpPages,
//        showNextButton: true,
//        showBackButton: true,
//        onTapDoneButton: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//        },
//        pageButtonTextStyles: TextStyle(
//          color: Colors.amberAccent,
//          fontSize: 13.0,
//        ),
//      ), //IntroViewsFlutter
//    ); //Builder
//  }

  const HelpScreens({Key key}) : super(key: key);

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildImage() {
    return Align(
      child: Image.network(kImageDemo, height: 175.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Be Happy",
          body: "Be Happy is a fun app that allows you to take your mood from sad to happy in an instant with a cute video! If you\'re happy you\'ll get a cool song!",
          image: Image.asset('assets/images/smilePink.png', height: 400.0, width: 400.0, alignment: Alignment.center),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.amberAccent,
            ),
            bodyTextStyle: TextStyle(fontSize: 22.0, color: Colors.amberAccent),
            dotsDecorator: DotsDecorator(
              activeColor: Colors.amberAccent,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Color(0xFF212121),
          ),
        ),
        PageViewModel(
          title: "Picture options",
          body: "You can either take a picture of yourself with the camera or choose a picture from your gallery",
          image: Image.asset('assets/images/buttons.png', height: 400.0, width: 400.0, alignment: Alignment.center),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.amberAccent,
            ),
            bodyTextStyle: TextStyle(fontSize: 22.0, color: Colors.amberAccent),
            dotsDecorator: DotsDecorator(
              activeColor: Colors.amberAccent,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Color(0xFF212121),
          ),
        ),
        PageViewModel(
          title: "Why?",
          body: "You can improve your mood and get a cool video!",
          image: Image.asset('assets/images/video.png', height: 400.0, width: 400.0, alignment: Alignment.center),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.amberAccent,
            ),
            bodyTextStyle: TextStyle(fontSize: 22.0, color: Colors.amberAccent),
            dotsDecorator: DotsDecorator(
              activeColor: Colors.amberAccent,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Color(0xFF212121),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('Skip', style: TextStyle(color: Colors.amberAccent)),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.amberAccent,
      ),
      done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent)),
    );
  }
}

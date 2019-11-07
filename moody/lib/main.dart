import 'package:flutter/material.dart';
import 'package:moody/helpers/intro_screen.dart';
import 'package:moody/views/home_page.dart';

void main() => runApp(Moody());

class Moody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'QuicksandL',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Moody',
      home: HelpScreens(),
    );
  }
}

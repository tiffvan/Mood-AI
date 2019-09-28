import 'package:flutter/material.dart';
import 'package:moody/views/home_page.dart';

void main() => runApp(Moody());

class Moody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moody',
      home: HomePage(),
    );
  }
}

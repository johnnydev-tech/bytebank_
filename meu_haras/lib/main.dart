import 'package:flutter/material.dart';
import 'view/Splash.dart';

void main() {
  runApp(MaterialApp(
    theme: new ThemeData(
      primaryColor: Color(0xffBD6654),
      accentColor: Color(0xffA3453D),
    ),
    title: 'Haras App',
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary,
            )),
        home: DashboardScreen(),
      ),
    );

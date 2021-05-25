import 'package:flutter/material.dart';
import 'package:haras_app/view/Principal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Inicio.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Principal()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Inicio()),
          (Route<dynamic> route) => false);
    }
  }

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        padding: EdgeInsets.fromLTRB(0, 16, 0, 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffA3453D),
              Color(0xffBD6654),
              Color(0xffA3453D),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    "images/logomenu.png",
                    width: MediaQuery.of(context).size.width * .6,
                  ),
                )),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Developed by",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Image.asset(
                      "images/dropc.png",
                      color: Colors.white,
                      height: 20,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

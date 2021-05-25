import 'package:flutter/material.dart';
import 'package:haras_app/view/Cadastro.dart';
import 'package:haras_app/view/Login.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "images/logo-new-white.png",
                      width: MediaQuery.of(context).size.width * .7,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Seja Bem Vindo!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                  highlightElevation: 0,
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Text(
                    "ENTRAR",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    highlightColor: Colors.white10,
                    splashColor: Colors.white54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Não tem uma conta?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "CADASTRE-SE",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cadastrar()));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

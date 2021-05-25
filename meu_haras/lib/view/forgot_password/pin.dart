import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haras_app/view/forgot_password/forgot_password.dart';
import 'package:haras_app/view/forgot_password/new_password.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:haras_app/Services/api.dart' as api;

class TelaPIN extends StatefulWidget {
  @override
  _TelaPINState createState() => _TelaPINState();
}

class _TelaPINState extends State<TelaPIN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "O PIN foi enviado para seu  e-mail",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1A2E35)),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "images/authentication.png",
                    width: MediaQuery.of(context).size.width * .7,
                  ),
                  Text(
                    "Digite o PIN abaixo",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFF4F5A)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Verifique sua caixa de Spam!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1A2E35)),
                  ),
                  PinEntryTextField(
                    onSubmit: (String pin) async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      Map data = {
                        'pin': pin,
                        'id': sharedPreferences.getString('usuario_id')
                      };
                      var jsonResponse;

                      var response = await http.post(
                          api.urlBase + "/Usuario/VerificaPin",
                          body: data);
                      if (response.statusCode == 200) {
                        jsonResponse = json.decode(response.body);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        if (jsonResponse != null) {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NovaSenha(pin: pin)));
                          });
                        }
                      } else {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("PIN INCORRETO!"),
                                  content:
                                      new Text("Deseja Cadastrar um novo PIN?"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: Text(
                                        "NÃO",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        });
                                      },
                                    ),
                                    new FlatButton(
                                      color: Colors.blue,
                                      child: Text("SIM"),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EsqueceuSenha()));
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        });
                        print(response.body);
                      }
                    }, // end onSubmit
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

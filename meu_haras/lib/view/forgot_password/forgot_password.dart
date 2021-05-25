import 'dart:convert';
import 'package:meu_haras/view/Cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meu_haras/Utils/Util.dart' as util;
import 'package:http/http.dart' as http;
import 'package:meu_haras/Services/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_haras/View/forgot_password/pin.dart';

class EsqueceuSenha extends StatefulWidget {
  @override
  _EsqueceuSenhaState createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              _header(),
              textSection(),
              SizedBox(height: 10.0),
              _isLoading ? Center(child: CircularProgressIndicator()) : button()
            ],
          ),
        ),
      ),
    );
  }

  signIn(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email};
    var jsonResponse = null;

    var response =
        await http.post(api.urlBase + "/Usuario/EsqueceuSenha", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString(
            'usuario_id', jsonResponse['id'].toString());

        //String id = sharedPreferences.getString('usuario_id');

        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaPIN()));
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("E-mail não encontrado!"),
                content: new Text("Deseja Cadastrar um novo usuário?"),
                actions: <Widget>[
                  new FlatButton(
                    child: Text(
                      "NÃO",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context, rootNavigator: true)
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
                                builder: (context) => Cadastrar()));
                      });
                    },
                  ),
                ],
              );
            });
      });
      print(response.body);
    }
  }

  Container button() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        splashColor: Theme.of(context).accentColor,
        onPressed: emailController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text);
              },
        elevation: 2.0,
        color: Theme.of(context).primaryColor,
        child: Text("ENTRAR",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();

  Container _header() {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Esqueceu a Senha?",
            style: GoogleFonts.roboto(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Tudo bem, isso acontece! \nProssiga com seu e-mail para a verificação!",
            style: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: emailController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: "E-mail",
          labelStyle: TextStyle(
              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w600),
          // icon: Icon(Icons.email, color: Color(0xffFF4F5A)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintStyle: TextStyle(color: Colors.black),
          helperText: util.msgemail,
          helperStyle: TextStyle(color: Colors.red),
        ),
        validator: util.validarEmail,
        onChanged: (String value) {
          setState(() {
            value = util.validarEmail(value);
          });
        },
      ),
    );
  }
}

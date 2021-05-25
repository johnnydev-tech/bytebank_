import 'dart:convert';
import 'package:meu_haras/view/Login.dart';
import 'package:meu_haras/view/forgot_password/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:meu_haras/Services/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NovaSenha extends StatefulWidget {
  final String pin;

  const NovaSenha({Key key, this.pin}) : super(key: key);

  @override
  _NovaSenhaState createState() => _NovaSenhaState();
}

class _NovaSenhaState extends State<NovaSenha> {
  bool _isLoading = false;
  String nome, email, senha;
  String msg = "";
  String valor = "";
  bool passwordVisible;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordconf = TextEditingController();

  _testesenha() {
    if (_password.text != _passwordconf.text) {
      setState(() {
        return msg = "Senhas não conferem!";
      });
    } else {
      msg = "";
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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

  signIn(String senha) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'password': senha,
      'id': sharedPreferences.getString('usuario_id'),
      'pin': widget.pin
    };
    var jsonResponse;

    var response =
        await http.post(api.urlBase + "/Usuario/AlteraSenha", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Erro"),
                content: new Text("Deseja Enviar o PIN novamente?"),
                actions: <Widget>[
                  new TextButton(
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
                  new TextButton(
                    child: Text("SIM"),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EsqueceuSenha()));
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
        splashColor: Colors.black54,
        onPressed: _password.text == "" ||
                _passwordconf.text == "" && _password.text.length < 6 ||
                _passwordconf.text.length < 6
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(_password.text);
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
            "Cadastrar Nova Senha",
            style: GoogleFonts.roboto(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Digite sua nova senha nos campos abaixo!",
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextFormField(
                controller: _password,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  helperText: msg,
                  helperStyle: TextStyle(color: Colors.red),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible
                            ? passwordVisible = false
                            : passwordVisible = true;
                      });
                    },
                  ),
                ),
                cursorColor: Colors.black,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return msg = "A Senha precisa ter pelo menos 6 caracteres!";
                },
                onChanged: (String value) {
                  setState(() {
                    value = _testesenha();
                  });
                },
                onSaved: (String val) {
                  senha = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextFormField(
                controller: _passwordconf,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: "Confirmar Senha",
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  helperText: msg,
                  helperStyle: TextStyle(color: Colors.red),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible
                            ? passwordVisible = false
                            : passwordVisible = true;
                      });
                    },
                  ),
                ),
                cursorColor: Colors.black,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return msg = "A Senha precisa ter pelo menos 6 caracteres!";
                },
                onChanged: (String value) {
                  setState(() {
                    value = _testesenha();
                  });
                },
              ),
            ),
          ],
        ));
  }
}

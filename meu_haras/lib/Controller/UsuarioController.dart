import 'package:flutter/material.dart';
import 'package:meu_haras/Model/usuario.dart';
import 'package:meu_haras/view/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioController {
  Future<String> post(UsuarioModel usuario) async {
    http.Response response = await http.post(
      api.urlBase + "/Usuario",
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(
        <String, String>{
          'nome': usuario.nome,
          'username': usuario.username,
          'password': usuario.password,
        },
      ),
    );

    return response.statusCode.toString();
  }

  Future<String> login(UsuarioModel usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResponse;

    http.Response response = await http.post(
      api.urlBase + "/login",
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(
        <String, String>{
          'username': usuario.username,
          'password': usuario.password,
        },
      ),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      print('Response body: ${response.body}');
      prefs.setString('token', jsonResponse['access_token']);
      String token = prefs.getString('token');
      print(token);
      // UsuarioController.getUsuario(token);
    }
    print('Response status: ${response.statusCode}');

    return response.statusCode.toString();
  }

  Future<String> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    http.Response response = await http.get(api.urlBase + "/logout", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}'
    });
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      prefs.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
      prefs.clear();
    } else {
      prefs.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
    print(response.body);
    return response.statusCode.toString();
  }
}

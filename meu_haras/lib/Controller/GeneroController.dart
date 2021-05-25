import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Model/genero.dart';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Genero>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  http.Response response = await http.get(
    api.urlBase + "/Genero",
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ).timeout(Duration(seconds: 25), onTimeout: () {
    return null;
  });

  var dadosJson = json.decode(response.body);
  //print(dadosJson.toString());

  List<Genero> generos = [];

  for (var genero in dadosJson) {
    // print("uf:" + uf["nome"] + " " + uf["sigla"]);

    Genero g = new Genero(
      id: genero["id"].toString(),
      nome: genero["nome"],
    );
    // print(g.toString());
    generos.add(g);
  }
  // print(ufs);
  return generos;
}

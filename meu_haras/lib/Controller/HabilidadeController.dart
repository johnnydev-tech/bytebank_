import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:haras_app/Model/habilidade.dart';
import 'package:haras_app/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Habilidade>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Linhagem",
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ).timeout(Duration(seconds: 25), onTimeout: () {
    return null;
  });

  var dadosJson = json.decode(response.body);

  List<Habilidade> habilidades = [];

  for (var habilidade in dadosJson) {
    Habilidade h = new Habilidade(
      id: habilidade["id"].toString(),
      nome: habilidade["nome"],
    );

    habilidades.add(h);
  }
  // print(ufs);
  return habilidades;
}

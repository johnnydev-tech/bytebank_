import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Model/treinado.dart';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Treinado>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Habilidade",
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

  List<Treinado> treinados = [];

  for (var treinado in dadosJson) {
    // print("uf:" + uf["nome"] + " " + uf["sigla"]);

    Treinado t = new Treinado(
      id: treinado["id"].toString(),
      nome: treinado["nome"],
    );
    //print(t.toString());
    treinados.add(t);
  }
  // print(ufs);
  return treinados;
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Model/pelagem.dart';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Pelagem>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Pelagem",
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

  List<Pelagem> pelagens = [];

  for (var pelagem in dadosJson) {
    // print("uf:" + uf["nome"] + " " + uf["sigla"]);

    Pelagem p = new Pelagem(
      id: pelagem["id"].toString(),
      nome: pelagem["nome"],
    );
    //print(p.toString());
    pelagens.add(p);
  }
  // print(ufs);
  return pelagens;
}

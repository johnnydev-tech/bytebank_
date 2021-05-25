import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:haras_app/Model/raca.dart';
import 'package:haras_app/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Raca>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Raca",
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

  List<Raca> racas = [];

  for (var raca in dadosJson) {
    // print("uf:" + uf["nome"] + " " + uf["sigla"]);

    Raca r = new Raca(
      id: raca["id"].toString(),
      nome: raca["nome"],
    );
    //print(r.toString());
    racas.add(r);
  }
  // print(ufs);
  return racas;
}

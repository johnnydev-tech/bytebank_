import 'package:meu_haras/Model/cidades.dart';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:meu_haras/Model/uf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Uf>> get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Uf",
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ).timeout(Duration(seconds: 25), onTimeout: () {
    return null;
  });

  var dadosJson = json.decode(response.body);
//  print(dadosJson.toString());

  List<Uf> ufs = [];

  for (var uf in dadosJson) {
    Uf u = new Uf(
      id: uf["id"].toString(),
      nome: uf["nome"],
      sigla: uf["sigla"],
    );
    //  print(u.toString());
    ufs.add(u);
  }
  // print(ufs);
  return ufs;
}

Future<List<Cidade>> getporUf(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  http.Response response = await http.get(
    api.urlBase + "/Cidade/ObterPorUf/$value",
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ).timeout(Duration(seconds: 25), onTimeout: () {
    return null;
  });

  var dadosJson = json.decode(response.body);
  print(dadosJson.toString());

  List<Cidade> cidades = [];

  for (var cidade in dadosJson) {
    //print("uf:" + cidade["nome"] + " " + cidade["Uf_id"].toString());

    Cidade c = new Cidade(
        id: cidade["id"].toString(),
        nome: cidade["nome"],
        ufId: cidade["Uf_id"].toString());
    //  print(c.toString());
    cidades.add(c);
  }
//  print(cidades);
  return cidades;
}

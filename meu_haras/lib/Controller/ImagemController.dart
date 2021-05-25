import 'package:meu_haras/Model/imagens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class ImagensApi {
  Future<List<Imagem>> get(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.Response response = await http.get(
      api.urlBase + "/Anuncio/Imagens/$id",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      //print("resultado: " + response.body);
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Imagem> imagens = dadosJson["imagens"].map<Imagem>((map) {
        return Imagem.fromJsom(map);
      }).toList();

      // print(dadosJson["imagens"].toString());
      return imagens;
    } else {
      print("resultado:" + response.statusCode.toString());
      return [];
    }
  }
}

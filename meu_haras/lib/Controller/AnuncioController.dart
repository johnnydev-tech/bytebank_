import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:meu_haras/view/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meu_haras/Services/api.dart' as api;
import 'package:meu_haras/Model/anuncio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnunciosApi {
  Future<List<Anuncio>> get(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);
    http.Response response = await http.get(
      api.urlBase + "/Anuncio",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      if (dadosJson['status'] == 'Token is Expired' ||
          dadosJson['status'] == 'Authorization Token not found' ||
          dadosJson['status'] == 'Token is Invalid') {
        prefs.clear();
        prefs.remove(token);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => Login(),
            ),
            (Route<dynamic> route) => false);
        return null;
      } else {
        Map<String, dynamic> dadosJson = json.decode(response.body);

        List<Anuncio> anuncios = dadosJson["anuncios"].map<Anuncio>((map) {
          return Anuncio.fromJsom(map);
        }).toList();
        print(dadosJson["anuncios"].toString());
        return anuncios;
      }
    } else {
      print("resultado:" + response.statusCode.toString());
      return [];
    }
  }

  // Future<Map<String, dynamic>> post(
  Future<String> post(
    titulo,
    preco,
    nomeAnunciante,
    whatsapp,
    descricao,
    selCidade,
    selRaca,
    selPelagem,
    selGenero,
    selTreinado,
    selHabilidade,
    idade,
    bool troca,
    bool parcela,
    String produto,
    List<File> imagens,
    String registro,
    String embriao,
    String nRegistro,
    String garanhao,
    String regGaranhao,
    String matriz,
    String regMatriz,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var uri = Uri.parse(api.urlBase + "/Anuncio");

    var request = http.MultipartRequest("POST", uri);

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    request.headers.addAll(headers);

    request.fields['titulo'] = titulo;
    request.fields['preco'] = preco;
    request.fields['nomeAnunciante'] = nomeAnunciante;
    request.fields['whatsapp'] = whatsapp;
    request.fields['descricao'] = descricao;
    request.fields['selCidade'] = selCidade;
    request.fields['selRaca'] = selRaca;
    request.fields['selPelagem'] = selPelagem;
    request.fields['selGenero'] = selGenero;
    request.fields['selTreinado'] = selTreinado;
    request.fields['selHabilidade'] = selHabilidade;
    request.fields['idade'] = idade;
    request.fields['parcela'] = parcela.toString();
    request.fields['troca'] = troca.toString();
    request.fields['selExpira'] = "1";
    request.fields['produto'] = produto;
    request.fields['registro'] = registro;
    request.fields['embriao'] = embriao;
    request.fields['numeroRegistro'] = nRegistro;
    request.fields['garanhao'] = garanhao;
    request.fields['regGaranhao'] = regGaranhao;
    request.fields['matriz'] = matriz;
    request.fields['regMatriz'] = regMatriz;

    for (var img in imagens) {
      String fileName = img.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));

      var length = await img.length();

      final multipart =
          http.MultipartFile('imagens[]', stream, length, filename: fileName);

      request.files.add(multipart);
    }

    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    return response.statusCode.toString();
  }
}

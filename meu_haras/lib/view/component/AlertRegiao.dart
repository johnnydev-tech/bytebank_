import 'package:flutter/material.dart';
import 'package:haras_app/Model/cidades.dart';
import 'package:haras_app/Model/uf.dart';
import 'package:haras_app/view/Principal.dart';
import 'package:haras_app/Controller/UfController.dart' as UfController;

class AlertRegiao extends StatefulWidget {
  @override
  _AlertRegiaoState createState() => _AlertRegiaoState();
}

class _AlertRegiaoState extends State<AlertRegiao> {
  String _valueUf;
  String _valueCidade = "";
  String estado;
  String cidadeid;
  String cidadenome;
  String ufsigla;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Text(
              "Escolha uma cidade",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            )),
            SizedBox(height: 15),
            Text(
              "Estado",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            FutureBuilder<List<Uf>>(
                future: UfController.get(),
                builder: (context, snapshot) {
                  return DropdownButtonFormField<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    value: _valueUf != null ? _valueUf : null,
                    onChanged: (value) {
                      setState(() {
                        _valueUf = value;
                        estado = _valueUf;
                        UfController.getporUf(estado);
                      });

                      //print("UF TESTE" + estado);
                      _valueCidade = null;
                    },
                    items: snapshot.data?.map((Uf uf) {
                          return DropdownMenuItem<String>(
                              value: uf.id,
                              child: new Text(
                                uf.sigla,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                ufsigla = uf.sigla;
                              });
                        })?.toList() ??
                        [],
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              "Cidade",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            FutureBuilder<List<Cidade>>(
                future: UfController.getporUf(estado),
                // ignore: missing_return
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center();
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).accentColor),
                        ),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                      } else {
                        return DropdownButtonFormField<String>(
                          icon: Icon(Icons.keyboard_arrow_down),
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          value: _valueCidade,
                          isExpanded: true,
                          hint: Text(""),
                          onChanged: (value) {
                            setState(() {
                              _valueCidade = value;
                            });
                            //print("Cidade TESTE" + _valueCidade.toString());
                          },
                          items: snapshot.data?.map((Cidade cidade) {
                                return DropdownMenuItem<String>(
                                  value: cidade.id,
                                  child: new Text(
                                    cidade.nome,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onTap: () {
                                    cidadeid = cidade.id;
                                    cidadenome = cidade.nome;
                                  },
                                );
                              })?.toList() ??
                              [],
                        );
                      }
                  }
                }),
          ],
        ),
      ),
      actions: <Widget>[
        new TextButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        new RaisedButton(
          color: Colors.green,
          child: Text("OK"),
          onPressed: _valueCidade == null || cidadenome == null
              ? null
              : () {
                  //  _salvarDados();
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Principal(
                                //   cidadeId: cidadeid,
                                //   cidadeNome: cidadenome,
                                //   estadoSigla: ufsigla,
                                )),
                        (Route<dynamic> route) => false);
                  });
                },
        ),
      ],
    );
  }
}

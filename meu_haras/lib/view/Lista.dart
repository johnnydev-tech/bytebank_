import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:haras_app/Controller/AnuncioController.dart';
import 'package:flutter/material.dart';
import 'package:haras_app/Model/anuncio.dart';
import 'package:haras_app/view/Detalhes.dart';

class Lista extends StatefulWidget {
  final String habilidade;
  final String raca;

  const Lista({
    Key key,
    this.habilidade,
    this.raca,
  }) : super(key: key);
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  AnunciosApi api = AnunciosApi();

  _listarAnuncio(context) {
    return api.get(context);
  }

  Future<void> _getData() async {
    await api.get(context);
  }

  @override
  void initState() {
    _listarAnuncio(context);
    print('Lista' + widget.raca + widget.habilidade);
    super.initState();
  }

  Widget get _refreshIsEmpty => RefreshIndicator(
        onRefresh: _getData,
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: OutlineButton.icon(
                highlightedBorderColor: Colors.white54,
                borderSide: BorderSide(color: Colors.grey.shade700, width: 2),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                splashColor: Colors.grey,
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                label: Flexible(
                  child: Text(
                    "Ocorreu um Erro! \nClique para Recarregar a Página!",
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _getData();
                  });
                },
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(5),
      child: FutureBuilder<List<Anuncio>>(
        future: _listarAnuncio(context),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("Sem Conexão"),
              );
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("Erro ao carregar lista!" + snapshot.toString());
                _refreshIsEmpty;
              } else {
                print("Lista carregada!");

                return RefreshIndicator(
                  onRefresh: _getData,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List<Anuncio> lista = snapshot.data;
                      Anuncio anuncio = lista[index];
                      return lista == null
                          ? Container()
                          : lista == []
                              ? _refreshIsEmpty
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: InkWell(
                                    child: Ink(
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 0.5,
                                              offset: Offset(0.0, 0.7),
                                            )
                                          ]),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                    base64Decode(
                                                      anuncio.thumb.toString(),
                                                    ),
                                                  ),
                                                  // MemoryImage(base64Decode(
                                                  //     anuncio.imagens.first)),
                                                  fit: BoxFit.cover,
                                                  scale: 1,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4))),
                                            height: 120,
                                            width: 120,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    anuncio.titulo,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    "R\$ ${anuncio.preco}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    anuncio.data,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    splashColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.1),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Detalhes(
                                              id: anuncio.id,
                                              titulo: anuncio.titulo,
                                              preco: anuncio.preco,
                                              descricao: anuncio.descricao,
                                              cidade: anuncio.cidade,
                                              nomeAnunciante:
                                                  anuncio.nomeAnunciante,
                                              raca: anuncio.raca,
                                              pelagem: anuncio.pelagem,
                                              genero: anuncio.genero,
                                              treinado: anuncio.treinado,
                                              habilidade: anuncio.habilidade,
                                              idade: anuncio.idade,
                                              whatsapp: anuncio.whatsapp,
                                              data: anuncio.data,
                                              parcela: anuncio.parcela,
                                              troca: anuncio.troca,
                                              embriao: anuncio.embriao,
                                              garanhao: anuncio.garanhao,
                                              regGaranhao: anuncio.regGaranhao,
                                              matriz: anuncio.regMatriz,
                                              numeroRegistro: anuncio.nRegistro,
                                              produto: anuncio.produto,
                                              regMatriz: anuncio.regMatriz,
                                              registro: anuncio.registro,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                );
                    },
                  ),
                );
              }
              break;
          }
        },
      ),
    );
  }
}

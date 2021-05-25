import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haras_app/Model/genero.dart';
import 'package:haras_app/Model/habilidade.dart';
import 'package:haras_app/Model/pelagem.dart';
import 'package:haras_app/Model/raca.dart';
import 'package:haras_app/Model/treinado.dart';
import 'package:haras_app/view/Lista.dart';
import 'package:haras_app/view/NovoAnuncio.dart';

import 'package:haras_app/view/component/AlertRegiao.dart';
import 'package:haras_app/Controller/RacaController.dart' as racaAPI;
import 'package:haras_app/Controller/PelagemController.dart' as pelagemAPI;
import 'package:haras_app/Controller/TreinadoController.dart' as treinadoAPI;
import 'package:haras_app/Controller/HabilidadeController.dart'
    as habilidadeAPI;
import 'package:haras_app/Controller/GeneroController.dart' as generoAPI;
import 'package:haras_app/view/more/more.dart';
import 'package:haras_app/view/profile/profile.dart';

class Principal extends StatefulWidget {
  final String raca;
  final String habilidade;

  const Principal({
    Key key,
    this.raca,
    this.habilidade,
  }) : super(key: key);
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  bool _troca = false;
  bool _parcela = false;
  String _valueRaca;
  String idRaca;
  String _valuePelagem;
  String idPelagem;
  String _valueTreinado;
  String idTreinado;
  String _valueHabilidade;
  String idHabilidade;
  String _valueGenero;
  String idGenero;

  void showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 1,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        ),
        context: context,
        builder: (context) {
          return SafeArea(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filtros:",
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CheckboxListTile(
                                activeColor: Theme.of(context).accentColor,
                                title: Text(
                                  "Parcelado",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                subtitle: Text("Aceita Parcelar"),
                                secondary: Icon(
                                  Icons.payment,
                                  color: Theme.of(context).accentColor,
                                ),
                                value: _parcela,
                                onChanged: (bool valor) {
                                  setState(() {
                                    _parcela = valor;
                                  });
                                }),
                            CheckboxListTile(
                                activeColor: Theme.of(context).accentColor,
                                title: Text(
                                  "Troca",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                subtitle: Text("Aceita Troca"),
                                secondary: Icon(
                                  Icons.swap_horiz_sharp,
                                  color: Theme.of(context).accentColor,
                                ),
                                value: _troca,
                                onChanged: (bool valor) {
                                  setState(() {
                                    _troca = valor;
                                  });
                                }),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).accentColor,
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Text(
                              "Características",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: .7,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Raça",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<List<Raca>>(
                                future: racaAPI.get(),
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                    ),
                                    value:
                                        _valueRaca != null ? _valueRaca : null,
                                    onChanged: (value) {
                                      setState(() {
                                        _valueRaca = value;
                                      });
                                    },
                                    items: snapshot.data?.map((Raca raca) {
                                          return DropdownMenuItem<String>(
                                              value: raca.id,
                                              child: new Text(
                                                raca.nome,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              onTap: () {
                                                idRaca = raca.id;
                                              });
                                        })?.toList() ??
                                        [],
                                  );
                                }),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Pelagem",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<List<Pelagem>>(
                                future: pelagemAPI.get(),
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                    ),
                                    value: _valuePelagem != null
                                        ? _valuePelagem
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        _valuePelagem = value;
                                      });
                                    },
                                    items:
                                        snapshot.data?.map((Pelagem pelagem) {
                                              return DropdownMenuItem<String>(
                                                  value: pelagem.id,
                                                  child: new Text(
                                                    pelagem.nome,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    idPelagem = pelagem.id;
                                                  });
                                            })?.toList() ??
                                            [],
                                  );
                                }),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Treinado para",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<List<Treinado>>(
                                future: treinadoAPI.get(),
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                    ),
                                    value: _valueTreinado != null
                                        ? _valueTreinado
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        _valueTreinado = value;
                                      });
                                    },
                                    items:
                                        snapshot.data?.map((Treinado treinado) {
                                              return DropdownMenuItem<String>(
                                                  value: treinado.id,
                                                  child: new Text(
                                                    treinado.nome,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    idTreinado = treinado.id;
                                                  });
                                            })?.toList() ??
                                            [],
                                  );
                                }),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Habilidade",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<List<Habilidade>>(
                                future: habilidadeAPI.get(),
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                    ),
                                    value: _valueHabilidade != null
                                        ? _valueHabilidade
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        _valueHabilidade = value;
                                      });
                                    },
                                    items: snapshot.data
                                            ?.map((Habilidade habilidade) {
                                          return DropdownMenuItem<String>(
                                              value: habilidade.id,
                                              child: new Text(
                                                habilidade.nome,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              onTap: () {
                                                idHabilidade = habilidade.id;
                                              });
                                        })?.toList() ??
                                        [],
                                  );
                                }),
                            SizedBox(
                              height: 26,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gênero",
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder<List<Genero>>(
                                    future: generoAPI.get(),
                                    builder: (context, snapshot) {
                                      return DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        decoration: new InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                        ),
                                        value: _valueGenero != null
                                            ? _valueGenero
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            _valueGenero = value;
                                          });
                                        },
                                        items: snapshot.data
                                                ?.map((Genero genero) {
                                              return DropdownMenuItem<String>(
                                                  value: genero.id,
                                                  child: new Text(
                                                    genero.nome,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    idGenero = genero.id;
                                                  });
                                            })?.toList() ??
                                            [],
                                      );
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Principal(
                                  habilidade: 'habilidade',
                                  raca: 'raca',
                                ),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        color: Colors.transparent,
                        child: Text("FILTRAR"),
                        textColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  int currentTab = 0;
  final List<Widget> screens = [
    Lista(raca: '', habilidade: ''),
    ProfileScreen(),
    MoreScreen(),
  ];
  Widget currentScreen = Lista(raca: '', habilidade: '');
  @override
  void initState() {
    print('TEste Filtro' + widget.habilidade + widget.raca);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Row(
          children: [
            Image.asset(
              "images/logomenu.png",
              height: 45,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Meu Haras',
              style: GoogleFonts.robotoSlab(),
            )
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            tooltip: 'Filtros',
            icon: Icon(
              Icons.filter_alt_sharp,
            ),
            onPressed: () => showModal(context),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffA3453D),
                Color(0xffBD6654),
              ],
            ),
          ),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         padding: EdgeInsets.all(0),
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //               image: AssetImage(
      //                 "images/cavalo.jpg",
      //               ),
      //               fit: BoxFit.cover),
      //         ),
      //         child: Container(
      //           height: 50,
      //           decoration: BoxDecoration(
      //             border: Border(
      //               left: BorderSide(width: 5.0, color: Colors.white24),
      //               right: BorderSide(width: 5.0, color: Colors.white24),
      //               bottom: BorderSide(width: 5.0, color: Colors.white24),
      //             ),
      //             gradient: LinearGradient(
      //                 begin: Alignment.topRight,
      //                 end: Alignment.bottomLeft,
      //                 colors: [
      //                   Colors.orange[800].withOpacity(.25),
      //                   Colors.brown[900].withOpacity(.50)
      //                 ]),
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 10.0),
      //                 child: Text(
      //                   " HARAS APP ",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 28,
      //                       backgroundColor: Theme.of(context).accentColor,
      //                       fontStyle: FontStyle.italic,
      //                       fontWeight: FontWeight.w400),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 10.0),
      //                 child: Text(
      //                   " Melhores preços! ",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 14,
      //                       letterSpacing: 1,
      //                       backgroundColor: Theme.of(context).primaryColor,
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.home,
      //           color: Colors.black54,
      //         ),
      //         title: Text(
      //           'Home',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.add_circle,
      //           color: Colors.black54,
      //         ),
      //         title: Text(
      //           'Anunciar',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.web,
      //           color: Colors.black54,
      //         ),
      //         title: Text(
      //           'Nosso site',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.share,
      //           color: Colors.black54,
      //         ),
      //         title: Text(
      //           'Compartlhe',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       Divider(
      //         thickness: 1,
      //         color: Colors.black54,
      //         height: 45,
      //         indent: 10,
      //         endIndent: 10,
      //       ),
      //       ListTile(
      //         title: Text(
      //           'Termos de Uso',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text(
      //           'Politicas de Privacidade',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text(
      //           'Precisa Ajuda?',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black54,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: currentScreen,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NovoAnuncio()))
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Lista(
                          habilidade: widget.habilidade,
                          raca: widget.raca,
                        );
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          'Inicio',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertRegiao();
                          },
                        );
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.map_outlined,
                          color: currentTab == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          'Região',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person_outline_rounded,
                          color: currentTab == 2
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          'Perfil',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MoreScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.more_horiz,
                          color: currentTab == 3
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          'Mais',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

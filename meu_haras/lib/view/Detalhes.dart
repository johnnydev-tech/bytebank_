import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_haras/Controller/ImagemController.dart';
import 'package:meu_haras/Model/imagens.dart';
import 'package:meu_haras/view/component/ImagemCompleta.dart';
import 'package:meu_haras/view/component/card_custom.dart';
import 'package:meu_haras/view/component/label_table.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Detalhes extends StatefulWidget {
  final String id;
  final String titulo;
  final String preco;
  final String nomeAnunciante;
  final String cidade;
  final String descricao;
  final String raca;
  final String pelagem;
  final String genero;
  final String habilidade;
  final String treinado;
  final String idade;
  final String whatsapp;
  final String data;
  final bool parcela;
  final bool troca;
  final String regMatriz;
  final String matriz;
  final String garanhao;
  final String regGaranhao;
  final String linhagem;
  final String embriao;
  final String numeroRegistro;
  final String registro;
  final String produto;

  const Detalhes({
    Key key,
    this.titulo,
    this.preco,
    this.descricao,
    this.raca,
    this.pelagem,
    this.genero,
    this.habilidade,
    this.treinado,
    this.idade,
    this.whatsapp,
    this.data,
    this.nomeAnunciante,
    this.cidade,
    this.id,
    this.parcela,
    this.troca,
    this.regMatriz,
    this.matriz,
    this.garanhao,
    this.regGaranhao,
    this.linhagem,
    this.embriao,
    this.numeroRegistro,
    this.registro,
    this.produto,
  }) : super(key: key);

  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  ImagensApi api = ImagensApi();

  _listarImagem() {
    print(widget.troca.toString() + widget.parcela.toString());
    return api.get(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    whats() async {
      var url =
          "https://api.whatsapp.com/send?phone=55${widget.whatsapp}&text=Olá,%20vi%20seu%20Anúncio%20no%20App%20Haras!";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Não encontrado! $url';
      }
    }

    exibirTelefone() {
      var telefone = "(" +
          widget.whatsapp.substring(0, 2) +
          ")" +
          " ${widget.whatsapp.substring(2, 7)}" +
          "-" +
          " ${widget.whatsapp.substring(7)}";
      return telefone;
    }

    fazerLigacao() async {
      var url = "tel:${widget.whatsapp}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Anúncio'),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .4,
                    child: FutureBuilder<List<Imagem>>(
                      future: _listarImagem(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Shimmer.fromColors(
                              baseColor: Colors.blueGrey[200],
                              highlightColor: Colors.white,
                              child: Center(
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            );
                            break;
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              print("Erro ao carregar lista!" +
                                  snapshot.toString());

                              return Container(
                                color: Colors.grey,
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: Text(
                                      "Ocorreu um erro ao carregar as imagens!"),
                                ),
                              );
                            } else {
                              print("Lista carregada!");
                              return CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height:
                                        MediaQuery.of(context).size.height * .4,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    List<Imagem> lista = snapshot.data;
                                    Imagem imagem = lista[index];

                                    return GestureDetector(
                                      child: Hero(
                                        tag: widget.id,
                                        child: Container(
                                          width: 500,
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            image: DecorationImage(
                                              image: MemoryImage(
                                                  base64.decode(imagem.imagem)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImagemDetalhe(
                                              idImagem: index,
                                              idAnuncio: widget.id,
                                            ),
                                          ),
                                        ),
                                      },
                                    );
                                  });
                            }
                            break;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    CardCustom(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.titulo,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "R\$ ${widget.preco}",
                            style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CardCustom(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Descrição:",
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: .7,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                          Divider(
                            thickness: 3,
                            color: Theme.of(context).accentColor,
                          ),
                          Text(
                            widget.descricao,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    CardCustom(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Características:",
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: .7,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                          Divider(
                            thickness: 3,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelTable(
                                    label: 'Raça:',
                                    value: widget.raca,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Pelagem:',
                                    value: widget.pelagem,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Gênero:',
                                    value: widget.genero,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LabelTable(
                                    label: 'Habilidade:',
                                    value: widget.habilidade,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Treinado para:',
                                    value: widget.treinado,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Idade:',
                                    value: widget.idade,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelTable(
                                    label: 'Reg. Matriz:',
                                    value: widget.regMatriz,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Matriz:',
                                    value: widget.matriz,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Gênero:',
                                    value: widget.genero,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Gênero:',
                                    value: widget.genero,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LabelTable(
                                    label: 'Habilidade:',
                                    value: widget.habilidade ?? '',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Treinado para:',
                                    value: widget.treinado ?? '',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Idade:',
                                    value: widget.idade ?? '',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTable(
                                    label: 'Gênero:',
                                    value: widget.genero,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          widget.parcela != null && widget.troca != null
                              ? Row(
                                  children: [
                                    widget.parcela
                                        ? Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Chip(
                                              label: Text(
                                                "Aceita Parcelar",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.brown.withOpacity(.2),
                                              shape: StadiumBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    widget.troca
                                        ? Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Chip(
                                              label: Text(
                                                "Aceita Troca",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.brown.withOpacity(.2),
                                              shape: StadiumBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    CardCustom(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dados Anúncio:",
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: .7,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                          Divider(
                            thickness: 3,
                            color: Theme.of(context).accentColor,
                          ),
                          Text(
                            "Anunciante:",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            widget.nomeAnunciante == null
                                ? "Anunciante"
                                : widget.nomeAnunciante,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Telefone:",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                fazerLigacao();
                              });
                            },
                            child: Text(
                              exibirTelefone(),
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationThickness: 1.5,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Região:",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            widget.cidade,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Postado em:",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            widget.data,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        splashColor: Colors.greenAccent,
        child: Image.asset(
          "images/whatsapp.png",
          height: 32,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          whats();
        },
      ),
    );
  }
}

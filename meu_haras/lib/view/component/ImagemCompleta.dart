import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:meu_haras/Controller/ImagemController.dart';
import 'package:meu_haras/Model/imagens.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class ImagemDetalhe extends StatefulWidget {
  final int idImagem;
  final String idAnuncio;

  const ImagemDetalhe({
    Key key,
    this.idImagem,
    this.idAnuncio,
  }) : super(key: key);

  @override
  _ImagemDetalheState createState() => _ImagemDetalheState();
}

class _ImagemDetalheState extends State<ImagemDetalhe> {
  ImagensApi apiImagem = ImagensApi();

  _listarImagem() {
    return apiImagem.get(widget.idAnuncio);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Align(
              alignment: Alignment.topCenter,
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
                        print("Erro ao carregar lista!" + snapshot.toString());
                        return Hero(
                          tag: widget.idAnuncio,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35.0),
                                bottomLeft: Radius.circular(35.0),
                              ),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage("images/fundo.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      } else {
                        print("Lista carregada!");

                        return CarouselSlider.builder(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              initialPage: widget.idImagem,
                              enableInfiniteScroll:
                                  snapshot.data.length == 1 ? false : true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List<Imagem> lista = snapshot.data;
                              Imagem imagem = lista[index];

                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(
                                          base64.decode(imagem.imagem)),
                                      fit: BoxFit.contain),
                                ),
                                child: PhotoView(
                                  initialScale:
                                      PhotoViewComputedScale.contained,
                                  maxScale:
                                      PhotoViewComputedScale.contained * 2,
                                  minScale:
                                      PhotoViewComputedScale.contained * .5,
                                  imageProvider:
                                      MemoryImage(base64.decode(imagem.imagem)),
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.black),
                                ),
                              );
                            });
                      }
                      break;
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 10,
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}

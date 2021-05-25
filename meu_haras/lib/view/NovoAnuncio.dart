import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haras_app/view/Principal.dart';
import 'package:haras_app/view/component/card_custom.dart';
import 'package:haras_app/view/component/dropDown/drop_down_genero.dart';
import 'package:haras_app/view/component/dropDown/drop_down_habilidade.dart';
import 'package:haras_app/view/component/dropDown/drop_down_linhagem.dart';
import 'package:haras_app/view/component/dropDown/drop_down_pelagem.dart';
import 'package:haras_app/view/component/dropDown/drop_down_raca.dart';
import 'package:haras_app/view/component/textField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haras_app/Controller/AnuncioController.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  Future<String> futureAnuncio;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  List produtos = ['Cavalo', 'Cobertura', 'Embrião'];
  List registros = ['Puro', 'Mestiço', 'Sem Registro'];
  List tiposEmb = ['Efetivado', 'Congelado'];
  String _tipoEmb = '';
  String _produto = '';
  String _registro = '';
  String _valueTipoEmb;
  String _valueProduto;
  String nomeTitulo = '';
  String _valueRegistro;
  String valor = '';
  List<File> _listaImagens = List();
  String idRaca;
  String idPelagem;
  String idTreinado;
  String idHabilidade;
  String idGenero;
  bool _troca = false;
  bool _parcela = false;
  bool isLoading = false;
  AnunciosApi api = AnunciosApi();
  String valueUf;
  String valueCidade = '';
  String estado;
  String cidadeid;
  String cidadenome;
  String ufsigla;

  _selecionarImagem() async {
    File imagemSelecionada =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  TextEditingController _titulo = TextEditingController();
  TextEditingController _preco = TextEditingController();
  TextEditingController _whatsapp = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _idade = TextEditingController();
  TextEditingController _nRegistro = TextEditingController();
  TextEditingController _registroMatriz = TextEditingController();
  TextEditingController _matriz = TextEditingController();
  TextEditingController _registroGaranhao = TextEditingController();
  TextEditingController _garanhao = TextEditingController();
  TextEditingController _dataEfetivacao = TextEditingController();

  void changeLinhagemId(String id) => setState(() {
        idHabilidade = id;
        print('Id Linhagem ' + idHabilidade);
      });

  void changeGeneroId(String id) => setState(() {
        idGenero = id;
        print('Id Genero ' + idGenero);
      });

  void changePelagemId(String id) => setState(() {
        idPelagem = id;
        print('Id Pelagem ' + idPelagem);
      });

//TODO: Alterar no banco Habilidade para Treinado
  void changeHabilidadeId(String id) => setState(() {
        idTreinado = id;
        print('Id Treinado ' + idTreinado);
      });

  void changeRacaId(String id) => setState(() {
        idRaca = id;
        print('Id Raca ' + idRaca);
      });

  _sendForm() async {
    if (_key.currentState.validate()) {
      futureAnuncio = await api
          .post(
        _titulo.text.trim(),
        _preco.text.trim(),
        "Johnny Freire",
        _whatsapp.text.trim(),
        _descricao.text.trim(),
        "8974",
        idRaca,
        idPelagem,
        idGenero,
        idTreinado,
        idHabilidade,
        _idade.text,
        _troca,
        _parcela,
        _produto,
        _listaImagens,
        _registro,
        _tipoEmb,
        _nRegistro.text.trim(),
        _garanhao.text.trim(),
        _registroGaranhao.text.trim(),
        _matriz.text.trim(),
        _registroMatriz.text.trim(),
      )
          .then((value) {
        valor = value;
        return null;
      });
      print(valor.toString());
      _key.currentState.save();
      if (valor.toString() == "200") {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Anúncio Cadastrado com Sucesso"),
                content:
                    new Text("Por favor aguarde a aprovação de seu anúncio!"),
                actions: <Widget>[
                  new FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Principal()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ],
              );
            });
      } else {
        setState(() {
          isLoading = false;
        });
        final snackbar = new SnackBar(content: Text("Erro ao Salvar anúncio!"));
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    } else {
      setState(() {
        isLoading = false;
        print(_key.currentState.validate().toString());
      });
    }
  }

  Widget _linhagemForm() => DropDownLinhagem(
        onChange: changeLinhagemId,
      );

  Widget _idadeForm() => TextFieldCustom(
        label: 'Idade',
        controller: _idade,
        inputType: TextInputType.text,
        maxLength: 11,
      );

  Widget _generoForm() => DropDownGenero(
        onChange: changeGeneroId,
      );

  Widget _habilidadeForm() => DropDownHabilidade(
        onChange: changeHabilidadeId,
      );

  Widget _racaForm() => DropDownRaca(
        onChange: changeRacaId,
      );

  Widget _registroFormField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Registro",
          ),
          const SizedBox(
            height: 6.0,
          ),
          DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            value: _valueRegistro != null ? _valueRegistro : null,
            onChanged: (value) {
              setState(() {
                _valueRegistro = value;
              });
            },
            items: registros.map((registro) {
                  return DropdownMenuItem<String>(
                      value: registro,
                      child: new Text(
                        registro,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        _registro = registro;
                      });
                })?.toList() ??
                [],
          ),
        ],
      );

  Widget _contentCavalo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _registroFormField(),
          _registro == "Puro" || _registro == "Mestiço"
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldCustom(
                        label: 'Nº Registro',
                        controller: _nRegistro,
                        inputType: TextInputType.number,
                        maxLength: 6,
                      ),

                      DropDownPelagem(onChange: changePelagemId),
                      const SizedBox(
                        height: 16.0,
                      ),
                      //TODO: Alterar Treinado para Habilidade
                      _habilidadeForm(),
                      const SizedBox(
                        height: 16,
                      ),
                      //Alterar no banco adicionar dados
                      _linhagemForm(),
                      const SizedBox(
                        height: 26,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _generoForm(),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: _idadeForm(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropDownPelagem(onChange: changePelagemId),
                      const SizedBox(
                        height: 16.0,
                      ),
                      //Alterar Treinado para Habilidade
                      _habilidadeForm(),
                      const SizedBox(
                        height: 16,
                      ),
                      //TODO: Alterar no banco adicionar dados ALterar Habilidade para Linhagem
                      _linhagemForm(),
                      const SizedBox(
                        height: 26,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _generoForm(),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: _idadeForm(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _contentCobertura(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldCustom(
            label: 'Nº Registro',
            controller: _nRegistro,
            inputType: TextInputType.number,
            maxLength: 6,
          ),
          DropDownPelagem(onChange: changePelagemId),
          const SizedBox(
            height: 16.0,
          ),
          //Alterar Treinado para Habilidade
          _habilidadeForm(),
          const SizedBox(
            height: 16.0,
          ),
          //Alterar no banco adicionar dados

          _idadeForm(),
        ],
      ),
    );
  }

  Widget _contentEmbriao(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFieldCustom(
                  label: 'Garanhão',
                  controller: _garanhao,
                  inputType: TextInputType.text,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextFieldCustom(
                  label: 'Nº de Regsitro',
                  controller: _registroGaranhao,
                  inputType: TextInputType.number,
                  maxLength: 6,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFieldCustom(
                  label: 'Matriz',
                  controller: _matriz,
                  inputType: TextInputType.text,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextFieldCustom(
                  label: 'Nº de Regsitro',
                  controller: _registroMatriz,
                  inputType: TextInputType.number,
                  maxLength: 6,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Tipo",
            ),
          ),
          DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            value: _valueTipoEmb != null ? _valueTipoEmb : null,
            onChanged: (value) {
              setState(() {
                _valueTipoEmb = value;
              });
            },
            items: tiposEmb.map((tipo) {
                  return DropdownMenuItem<String>(
                      value: tipo,
                      child: new Text(
                        tipo,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        _tipoEmb = tipo;
                      });
                })?.toList() ??
                [],
          ),
          _tipoEmb == "Efetivado"
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFieldCustom(
                    label: 'Data Efetivação',
                    controller: _dataEfetivacao,
                    inputType: TextInputType.datetime,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Novo Anúncio',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CardCustom(
                    content: FormField<List>(
                      initialValue: _listaImagens,
                      validator: (imagens) {
                        if (imagens.length == 0) {
                          return "Necessário selecionar uma imagem";
                        }
                        return null;
                      },
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Adicionar Imagens",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: .7,
                                  color: Colors.grey[500]),
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _listaImagens.length + 1,
                                itemBuilder: (context, index) {
                                  // ignore: missing_return
                                  if (index == _listaImagens.length) {
                                    // ignore: missing_return
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selecionarImagem();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          radius: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo,
                                                  size: 40,
                                                  color: Colors.grey[100]),
                                              Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    color: Colors.grey[100]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  if (_listaImagens.length > 0) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.file(
                                                              _listaImagens[
                                                                  index]),
                                                          FlatButton(
                                                            textColor:
                                                                Colors.red,
                                                            child: Text(
                                                                "Remover Imagem"),
                                                            onPressed: () {
                                                              setState(() {
                                                                _listaImagens
                                                                    .removeAt(
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white54,
                                          backgroundImage:
                                              FileImage(_listaImagens[index]),
                                          radius: 50,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.delete,
                                              size: 40,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (state.hasError)
                              Container(
                                child: Text(
                                  "[${state.errorText}]",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                  CardCustom(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Características",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: .7,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        _racaForm(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Produto",
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        DropdownButtonFormField<String>(
                          icon: Icon(Icons.keyboard_arrow_down),
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          value: _valueProduto != null ? _valueProduto : null,
                          onChanged: (value) {
                            setState(() {
                              _valueProduto = value;
                            });
                          },
                          items: produtos.map((produto) {
                                return DropdownMenuItem<String>(
                                    value: produto,
                                    child: new Text(
                                      produto,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      _produto = produto;
                                      if (_produto == 'Embrião') {
                                        setState(() {
                                          _titulo = TextEditingController(
                                              text: 'Embrião');
                                        });
                                      } else {
                                        _titulo =
                                            TextEditingController(text: '');
                                      }
                                    });
                              })?.toList() ??
                              [],
                        ),
                        _produto == 'Embrião'
                            ? _contentEmbriao(context)
                            : _produto == "Cavalo"
                                ? _contentCavalo(context)
                                : _produto == "Cobertura"
                                    ? _contentCobertura(context)
                                    : Container()

                        // CAVALO ->
                        // CAMPO REGISTRO* {PURO, MESTIÇO, SEM REGISTRO}
                        // PURO OU MESTIÇO - > CAMPO REGISTRO* ( NÚMERICO)
                        //
                        // COBERTURA ->
                        // CAMPO REGISTRO* {PURO, MESTIÇO}
                        // PURO OU MESTIÇO - > CAMPO REGISTRO* (NÚMERICO)
                        //
                        // EMBRIÃO ->
                        // TIPO* - > {CONGELADO, EFETIVADO}
                        // EFETIVADO*-> DATA
                        // GARANHÃO-> STRING
                        // MATRIZ-> STRING
                      ],
                    ),
                  ),
                  CardCustom(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Dados",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: .7,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextFieldCustom(
                          label: 'Nome',
                          controller: _titulo,
                          inputType: TextInputType.text,
                        ),
                        TextFieldCustom(
                          label: 'Preço',
                          controller: _preco,
                          inputType: TextInputType.number,
                        ),
                        TextFieldCustom(
                          label: 'Whatsapp',
                          controller: _whatsapp,
                          hint: '(##) ######-####',
                          inputType: TextInputType.phone,
                          maxLength: 11,
                        ),
                        TextFieldCustom(
                          label: 'Descrição',
                          controller: _descricao,
                          inputType: TextInputType.multiline,
                          maxLength: 500,
                          maxLines: 16,
                        ),
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
                            onChanged: (bool value) {
                              setState(() {
                                _parcela = value;
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
                      ],
                    ),
                  ),
                  CardCustom(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        const SizedBox(height: 15),
                        Text(
                          "Estado",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*
                        const SizedBox(height: 6.0),
                        FutureBuilder<List<Uf>>(
                            future: UfController.get(),
                            builder: (context, snapshot) {
                              return DropdownButtonFormField<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
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
                        const SizedBox(height: 16.0),
                        Text(
                          "Cidade",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6.0),
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
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
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
                                      items: snapshot.data
                                              ?.map((Cidade cidade) {
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
                            }),*/
                        const SizedBox(
                          height: 26,
                        ),
                        RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            elevation: 2,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                            splashColor: Theme.of(context).accentColor,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              "ENVIAR ANÚNCIO",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: _titulo.text == '' ||
                                    _preco.text == '' ||
                                    _whatsapp.text == '' ||
                                    _descricao.text == ''
                                ? null
                                : () {
                                    setState(() {
                                      isLoading = true;
                                      _sendForm();
                                    });
                                  }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meu_haras/Controller/UsuarioController.dart';
import 'package:meu_haras/Model/usuario.dart';
import 'package:meu_haras/view/Login.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  Future<String> futureUsuario;
  final _key = GlobalKey<FormState>();
  TextEditingController _nome;
  TextEditingController _username;
  TextEditingController _password;
  bool validate = false;
  String valor;
  bool _isLoading = false;
  bool _visible;
  UsuarioController usuarioController = UsuarioController();

  @override
  void initState() {
    _nome = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();

    _visible = true;
    super.initState();
  }

  void submit() async {
    FocusScope.of(context).unfocus();

    if (_key.currentState.validate()) {
      final nome = _nome.text.trim();
      final password = _password.text.trim();
      final username = _username.text.trim();

      futureUsuario = await usuarioController
          .post(UsuarioModel(
        nome: nome,
        username: username,
        password: password,
      ))
          .then((value) {
        valor = value;

        return null;
      });
      if (valor == "200") {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Seja Bem Vindo!"),
                content: new Text("Usuário Cadastradoo!"),
                actions: <Widget>[
                  new TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      });
                    },
                  ),
                ],
              );
            });
      } else if (valor.toString() == "409") {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Usuário já Cadastrado"),
                content: new Text("Por favor utilize outro e-mail!"),
                actions: <Widget>[
                  new TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      });
                    },
                  ),
                ],
              );
            });
      } else {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Erro"),
                content: new Text("Por favor tente novamente mais tarde!"),
                actions: <Widget>[
                  new TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      });
                    },
                  ),
                ],
              );
            });
      }
    } else {
      // erro de validação
      setState(() {
        print(_key.currentState.validate().toString());
        validate = true;
      });
    }
  }

  void _togglePasswordVisibility() => setState(
        () => _visible = !_visible,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "images/logo-new-white.png",
                      height: MediaQuery.of(context).size.height * .2,
                      color: Color(0xffA3453D),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "CADASTRE-SE",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nome,
                            decoration: const InputDecoration(
                                labelText: 'Nome *',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _username,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'E-mail *',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: _visible,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _visible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                labelText: 'Senha *',
                                border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            elevation: 2,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                            //  color:  Color(0xffEE8700),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              "CADASTRAR",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _isLoading = true;
                              submit();
                            },
                          ),
                    TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Já tem uma conta? ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

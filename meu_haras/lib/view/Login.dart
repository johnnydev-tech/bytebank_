import 'package:flutter/material.dart';
import 'package:meu_haras/Controller/UsuarioController.dart';
import 'package:meu_haras/Model/usuario.dart';
import 'package:meu_haras/view/Cadastro.dart';
import 'package:meu_haras/view/Principal.dart';
import 'package:meu_haras/view/forgot_password/forgot_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<String> futureUsuario;
  final _key = GlobalKey<FormState>();
  TextEditingController _username;
  TextEditingController _password;
  bool validate = false;
  String valor;
  bool _isLoading = false;
  bool _visible;
  UsuarioController usuarioController = UsuarioController();

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    _visible = true;
    super.initState();
  }

  void submit() async {
    FocusScope.of(context).unfocus();

    if (_key.currentState.validate()) {
      final password = _password.text.trim();
      final username = _username.text.trim();

      futureUsuario = await usuarioController
          .login(UsuarioModel(
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
                actions: <Widget>[
                  new FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Principal(
                              habilidade: '',
                              raca: '',
                            ),
                          ),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              );
            });
      } else if (valor.toString() == "401") {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("E-mail ou senha inválidos"),
                content: new Text("Por favor tente novamente!"),
                actions: <Widget>[
                  new FlatButton(
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
                  new FlatButton(
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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _key,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Hero(
                                  tag: 'logo',
                                  child: Image.asset(
                                    "images/logo-new-white.png",
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    color: Color(0xffA3453D),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller: _username,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'E-mail *',
                                    border: OutlineInputBorder()),
                              ),
                              const SizedBox(
                                height: 12.0,
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
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlatButton(
                                    child: Text("Esqueceu a Senha?"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EsqueceuSenha()));
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      elevation: 2,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                      ),
                                      //  color:  Color(0xffEE8700),
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      child: Text(
                                        "ENTRAR",
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  child: Wrap(
                    children: [
                      Text(
                        "Não tem uma conta? ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Cadastre-se",
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
                        MaterialPageRoute(builder: (context) => Cadastrar()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

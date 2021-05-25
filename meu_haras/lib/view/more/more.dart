import 'package:flutter/material.dart';
import 'package:meu_haras/Controller/UsuarioController.dart';
import 'package:meu_haras/view/Login.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  UsuarioController usuarioController = UsuarioController();
  String valor = "";

  void logout(context) async {
    await usuarioController.logout(context).then((value) => valor = value);
    print(valor);
    if (valor == "200") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    } else {
      print('erro ' + valor);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }
}

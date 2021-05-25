import 'package:flutter/material.dart';
import 'package:meu_haras/Model/genero.dart';
import 'package:meu_haras/Controller/GeneroController.dart' as generoAPI;

class DropDownGenero extends StatefulWidget {
  final Function(String) onChange;

  const DropDownGenero({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  @override
  _DropDownGeneroState createState() => _DropDownGeneroState();
}

class _DropDownGeneroState extends State<DropDownGenero> {
  String value;

  void onSelectGenero(String id) => setState(
        () {
          widget.onChange(id);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gênero',
          ),
          SizedBox(
            height: 6.0,
          ),
          FutureBuilder<List<Genero>>(
            future: generoAPI.get(),
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                value: value ?? null,
                onChanged: (value) => onSelectGenero(value),
                items: snapshot.data?.map((Genero genero) {
                      return DropdownMenuItem<String>(
                        value: genero.id,
                        child: new Text(
                          genero.nome,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    })?.toList() ??
                    [],
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:haras_app/Controller/TreinadoController.dart' as treinadoAPI;
import 'package:haras_app/Model/treinado.dart';

class DropDownHabilidade extends StatefulWidget {
  final Function(String) onChange;

  const DropDownHabilidade({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  @override
  _DropDownHabilidadeState createState() => _DropDownHabilidadeState();
}

class _DropDownHabilidadeState extends State<DropDownHabilidade> {
  String value;

  void onSelectHabilidade(String id) => setState(
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
            "Habilidade",
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Treinado>>(
              future: treinadoAPI.get(),
              builder: (context, snapshot) {
                return DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  value: value ?? null,
                  onChanged: (value) => onSelectHabilidade(value),
                  items: snapshot.data?.map((Treinado treinado) {
                        return DropdownMenuItem<String>(
                          value: treinado.id,
                          child: new Text(
                            treinado.nome,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        );
                      })?.toList() ??
                      [],
                );
              }),
        ],
      ),
    );
  }
}

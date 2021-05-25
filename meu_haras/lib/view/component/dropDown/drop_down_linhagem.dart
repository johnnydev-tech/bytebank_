import 'package:flutter/material.dart';
import 'package:haras_app/Model/habilidade.dart';
import 'package:haras_app/Controller/HabilidadeController.dart'
    as habilidadeAPI;

class DropDownLinhagem extends StatefulWidget {
  final Function(String) onChange;

  const DropDownLinhagem({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  @override
  _DropDownLinhagemState createState() => _DropDownLinhagemState();
}

class _DropDownLinhagemState extends State<DropDownLinhagem> {
  String value;

  void onSelectLinhagem(String id) => setState(
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
            'Linhagem',
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Habilidade>>(
              future: habilidadeAPI.get(),
              builder: (context, snapshot) {
                return DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  value: value ?? null,
                  onChanged: (value) => onSelectLinhagem(value),
                  items: snapshot.data?.map((Habilidade habilidade) {
                        return DropdownMenuItem<String>(
                          value: habilidade.id,
                          child: new Text(
                            habilidade.nome,
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

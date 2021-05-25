import 'package:flutter/material.dart';
import 'package:meu_haras/Controller/PelagemController.dart' as pelagemAPI;
import 'package:meu_haras/Model/pelagem.dart';

class DropDownPelagem extends StatefulWidget {
  final Function(String) onChange;

  const DropDownPelagem({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  _DropDownPelagemState createState() => _DropDownPelagemState();
}

class _DropDownPelagemState extends State<DropDownPelagem> {
  String value;

  void onSelectPelagem(String id) => setState(
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
            "Pelagem",
          ),
          const SizedBox(
            height: 6.0,
          ),
          FutureBuilder<List<Pelagem>>(
            future: pelagemAPI.get(),
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                value: value ?? null,
                onChanged: (value) => onSelectPelagem(value),
                items: snapshot.data?.map((Pelagem pelagem) {
                      return DropdownMenuItem<String>(
                        value: pelagem.id,
                        child: new Text(
                          pelagem.nome,
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

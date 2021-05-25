import 'package:flutter/material.dart';
import 'package:meu_haras/Model/raca.dart';
import 'package:meu_haras/Controller/RacaController.dart' as racaAPI;

class DropDownRaca extends StatefulWidget {
  final Function(String) onChange;

  const DropDownRaca({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  @override
  _DropDownRacaState createState() => _DropDownRacaState();
}

class _DropDownRacaState extends State<DropDownRaca> {
  String value;

  void onSelectRaca(String id) => setState(
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
            'Raça',
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Raca>>(
            future: racaAPI.get(),
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                value: value ?? null,
                onChanged: (value) => onSelectRaca(value),
                items: snapshot.data?.map((Raca raca) {
                      return DropdownMenuItem<String>(
                        value: raca.id,
                        child: new Text(
                          raca.nome,
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

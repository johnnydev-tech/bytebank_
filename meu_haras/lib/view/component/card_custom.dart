import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final Widget content;

  const CardCustom({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: content,
    );
  }
}

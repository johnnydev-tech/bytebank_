import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType inputType;

  const TextFieldCustom({
    Key key,
    this.controller,
    this.maxLength,
    this.inputType,
    this.label,
    this.hint,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
          ),
          const SizedBox(
            height: 6.0,
          ),
          TextFormField(
            controller: controller,
            maxLength: maxLength,
            maxLines: maxLines,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
              fillColor: Colors.black,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

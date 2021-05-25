import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelTable extends StatelessWidget {
  final String label;
  final String value;

  const LabelTable({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

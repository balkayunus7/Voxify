import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({required this.subtitle, required this.color, super.key});

  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(subtitle,
        style: GoogleFonts.lato(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ));
  }
}

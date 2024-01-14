
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voxify/product/constants/color_constants.dart';

class GoogleText extends StatelessWidget {
  const GoogleText({
    super.key,
    required this.text, required this.fontSize,
  });
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.lato(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: ColorConstants.primaryDark,
      ),
    );
  }
}

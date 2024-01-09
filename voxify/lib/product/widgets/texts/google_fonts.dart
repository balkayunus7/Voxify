import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voxify/product/constants/color_constants.dart';

class GoogleText extends StatelessWidget {
  const GoogleText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorConstants.primaryDark,
      ),
    );
  }
}

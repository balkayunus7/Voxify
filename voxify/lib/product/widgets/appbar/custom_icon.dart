import 'package:flutter/material.dart';
import 'package:voxify/product/constants/color_constants.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: ColorConstants.primaryGreenDark,
        onPressed: onPressed,
        icon: Icon(icon));
  }
}
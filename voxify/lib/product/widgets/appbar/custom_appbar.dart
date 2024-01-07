import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../texts/title_text.dart';
import 'custom_icon_appbar.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar(
    this.title, {
    super.key,
    required this.iconColor,
    required super.preferredSize,
    required super.child,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconAppBar(
        iconColor: iconColor,
        iconData: Icons.arrow_back,
        onPressed: onPressed,
      ),
      centerTitle: true,
      title: TitleText(
        title: title,
        color: ColorConstants.primaryDark,
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

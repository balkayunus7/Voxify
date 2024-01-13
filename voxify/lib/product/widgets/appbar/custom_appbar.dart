import 'package:flutter/material.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import '../../constants/color_constants.dart';
import '../texts/title_text.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar(
    this.title, {
    required this.icon,
    super.key,
    required super.preferredSize,
    required super.child,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
      iconSize: WidgetSize.iconNormal.value,
      onPressed: onPressed,
      icon: Icon(icon),
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

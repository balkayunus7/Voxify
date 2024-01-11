import 'package:flutter/material.dart';

import '../../enums/widget_sizes.dart';

class IconAppBar extends StatelessWidget {
  const IconAppBar({
    required this.onPressed,
    required this.iconData,
    super.key,
  });

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: WidgetSize.iconNormal.value,
      onPressed: onPressed,
      icon: Icon(iconData,size: 28,),
    );
  }
}
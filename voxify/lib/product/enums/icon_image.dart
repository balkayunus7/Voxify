import 'package:flutter/material.dart';

enum IconConstants {
  logo('logo'),
  height('125');
  final String value;
  const IconConstants(this.value);

  String get toPng => 'assets/icon/$value.png';
  Image get toImage => Image.asset(
        toPng,
        height: double.parse(height.value),
      );
}
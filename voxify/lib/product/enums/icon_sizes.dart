import 'package:flutter/material.dart';
import 'package:voxify/product/enums/image_sizes.dart';

enum IconConstants {
  playstore('playstore'),
  logo('logo'),
  lock('lock'),
  ;

  final String value;
  // ignore: sort_constructors_first
  const IconConstants(this.value);

  String get toPng => 'assets/icon/$value.png';
  Image get toImage => Image.asset(
        toPng,
        height: ImageSize.height.value.toDouble(),
      );
}
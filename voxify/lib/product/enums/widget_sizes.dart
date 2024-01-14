import 'package:flutter/material.dart';

enum WidgetSize {
  butttonNormal(56),
  iconNormal(30),
  sizedBoxLow(10),
  sizedBoxNormal(20),
  sizedBoxBig(50),
  avatarRadius(50),
  paddingAuthTop(125),
  fontSizeNormal(16),
  fontSizeBig(35),
  sliderOpenSize(180);


  final double value;
  const WidgetSize(this.value);
}


class WidgetSizeConstants {
 static   BorderRadius get borderRadiusNormal => BorderRadius.circular(10);
 static   BorderRadius get borderRadiusBig => BorderRadius.circular(10);
 static   EdgeInsets get navigationPadding => const EdgeInsets.symmetric(horizontal: 15, vertical: 10);
}
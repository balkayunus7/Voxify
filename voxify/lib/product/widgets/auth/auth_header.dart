import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import '../../constants/color_constants.dart';
import '../../enums/icon_image.dart';
import '../texts/subtitle_text.dart';
import '../texts/title_text.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth(
      {super.key, required this.titleText, required this.subtitleText});

  final String titleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: context.padding.onlyBottomNormal,
          child: ClipRRect(
              borderRadius: WidgetSizeConstants.borderRadiusNormal,
              child: IconConstants.logo.toImage),
        ),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: TitleText(
            title: titleText,
            color: ColorConstants.primaryGreenDark,
          ),
        ),
        SubtitleText(
          subtitle: subtitleText,
          color: ColorConstants.primaryGrey,
        ),
      ],
    );
  }
}

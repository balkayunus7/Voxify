import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/enums/widget_sizes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
          leftDotColor: ColorConstants.primaryGreenDark,
          rightDotColor: ColorConstants.primaryDark,
          size: WidgetSize.loadingSize.value),
    );
  }
}

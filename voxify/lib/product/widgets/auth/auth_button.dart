// * Buy Button of Car Details Page
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../constants/color_constants.dart';
import '../../enums/widget_sizes.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.iconText, required this.onPressed});

  final String iconText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalNormal,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.primaryGreenDark,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: context.border.normalBorderRadius,
            ),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: WidgetSize.sizedBoxBig.value,
          child: Center(
            child: Text(
              iconText,
              style: TextStyle(
                color: ColorConstants.primaryWhite,
                fontSize: WidgetSize.fontSizeNormal.value,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

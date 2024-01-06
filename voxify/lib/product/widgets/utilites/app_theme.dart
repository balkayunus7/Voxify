import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../constants/color_constants.dart';

@immutable
class AppTheme {
  const AppTheme({required this.context});

  final BuildContext context;
  ThemeData get theme => ThemeData.light().copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(15),
            ),
            textStyle: MaterialStateProperty.all<TextStyle?>(
              context.general.textTheme.bodyLarge,
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              ColorConstants.primaryGreen,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
        ),
      );
}

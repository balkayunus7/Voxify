import 'package:flutter/material.dart';
import 'package:voxify/feature/home/home_view.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/initialize/application_start.dart';
import 'package:voxify/product/widgets/utilites/app_theme.dart';

Future<void> main() async {
  await AppliactionStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context: context).theme,
      home: const HomeView(),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../product/constants/color_constants.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/icon_sizes.dart';
import '../../product/widgets/texts/wavy_text.dart';
import '../auth/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
  
class _SplashViewState extends State<SplashView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkStatus();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.logo.toImage,
            Padding(
              padding: context.padding.onlyTopLow,
              child: const WavyText(title: StringConstants.appName),
            ),
          ],
        ),
      ),
    );
  }
  void checkStatus() async {
    Future.delayed(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/product/enums/image_sizes.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/widget_sizes.dart';
import '../../product/widgets/auth/auth_button.dart';
import '../../product/widgets/auth/auth_header.dart';
import '../../product/widgets/textfields/custom_textfield.dart';
import 'register_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.low
              .copyWith(top: WidgetSize.paddingAuthTop.value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeaderAuth(
                  titleText: StringConstants.login,
                  subtitleText: StringConstants.welcomeBack,
                ),
                SizedBox(height: WidgetSize.sizedBoxNormal.value),
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfield(
                        controller: _emailController,
                        hintText: StringConstants.hintTextEmail,
                        iconFirst: Icons.email)),
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfieldPassword(
                        controller: _passwordController,
                        hintText: StringConstants.hintTextPassword,
                        iconFirst: Icons.lock)),
                Padding(
                  padding: context.padding.onlyRightNormal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child:
                            _authText(context, StringConstants.forgotPassword),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: context.padding.normal,
                    child: GestureDetector(
                      onTap: () {},
                      child: AuthButton(
                          iconText: StringConstants.login, onPressed: () {}),
                    )),
                GestureDetector(
                  onTap: () {
                    context.route.navigateToPage(const RegisterPage());
                  },
                  child: _authText(context, StringConstants.routingTextLogin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _authText(BuildContext context, String text) {
    return Text(text,
        style: context.general.textTheme.bodySmall!
            .copyWith(fontWeight: FontWeight.bold));
  }
}

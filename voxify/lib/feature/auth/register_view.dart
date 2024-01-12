import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/auth/providers/auth_notifier.dart';
import 'package:voxify/feature/auth/login_view.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/widget_sizes.dart';
import '../../product/widgets/auth/auth_button.dart';
import '../../product/widgets/auth/auth_header.dart';
import '../../product/widgets/textfields/custom_textfield.dart';




class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
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
                    titleText: StringConstants.register,
                    subtitleText: StringConstants.welcomeBack,
                  ),
                  Padding(
                      padding: context.padding.normal,
                      child: CustomTextfield(
                          controller: _usernameController,
                          hintText: StringConstants.hintName,
                          iconFirst: Icons.email)),
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
                      padding: context.padding.normal,
                      child: AuthButton(
                          iconText: StringConstants.register,
                          onPressed: () {
                            auth
                                .signUpUserWithFirebase(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text)
                                // ignore: body_might_complete_normally_catch_error
                                .catchError((e) {
                              auth.errorMessage(context, e,
                                  'Register is Failed! ${e.toString()}');
                            }).then((value) => context.route
                                    .navigateToPage(const LoginPage()));
                          })),
                  GestureDetector(
                    onTap: () {
                      context.route.navigateToPage(const LoginPage());
                    },
                    child:
                        _authText(context, StringConstants.routingTextRegister),
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
  





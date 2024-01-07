import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/auth/login_view.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/widget_sizes.dart';
import '../../product/widgets/auth/auth_button.dart';
import '../../product/widgets/auth/auth_header.dart';
import '../../product/widgets/textfields/custom_textfield.dart';
import 'cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthCubit _authCubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
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
                            _authCubit
                                .signUpUserWithFirebase(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text)
                                // ignore: body_might_complete_normally_catch_error
                                .catchError((e) {
                              _authCubit.errorMessage(context, e,
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
      ),
    );
  }

  Text _authText(BuildContext context, String text) {
    return Text(text,
        style: context.general.textTheme.bodySmall!
            .copyWith(fontWeight: FontWeight.bold));
  }
}

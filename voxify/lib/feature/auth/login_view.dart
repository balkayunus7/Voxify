import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/auth/providers/auth_notifier.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/widget_sizes.dart';
import '../../product/widgets/auth/auth_button.dart';
import '../../product/widgets/auth/auth_header.dart';
import '../../product/widgets/textfields/custom_textfield.dart';
import '../home/home_view.dart';
import 'register_view.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
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
                          iconText: StringConstants.login,
                          onPressed: () {
                            auth
                                .loginUserWithFirebase(_emailController.text,
                                    _passwordController.text)
                                // ignore: body_might_complete_normally_catch_error
                                .catchError((e) {
                              auth.errorMessage(context, e,
                                  'Login is Failed! ${e.toString()}');
                            }).then((value) => context.route
                                    .navigateToPage(const HomePage()));
                          }),
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

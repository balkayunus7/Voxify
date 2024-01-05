import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../product/constants/color_constants.dart';
import '../../product/constants/string_constants.dart';
import '../../product/enums/icon_sizes.dart';
import '../../product/enums/widget_sizes.dart';
import '../../product/widgets/textfields/custom_textfield.dart';
import '../../product/widgets/texts/subtitle_text.dart';
import '../../product/widgets/texts/title_text.dart';

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
                const _Header(),
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
                  padding: context.padding.onlyBottomLow
                      .add(context.padding.onlyRightNormal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(StringConstants.forgotPassword,
                            style: context.general.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: context.padding.normal,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(StringConstants.routingTextLogin,
                          style: context.general.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: WidgetSize.sizedBoxNormal.value),
        Padding(
          padding: context.padding.onlyBottomNormal,
          child: ClipRRect(
              borderRadius: context.border.lowBorderRadius,
              child: IconConstants.playstore.toImage),
        ),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: const TitleText(
            title: StringConstants.login,
            color: ColorConstants.primaryOrange,
          ),
        ),
        const SubtitleText(
          subtitle: StringConstants.welcomeBack,
          color: ColorConstants.primaryGrey,
        ),
      ],
    );
  }
}

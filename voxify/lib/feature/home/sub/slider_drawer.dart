import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import 'package:voxify/product/widgets/texts/google_fonts.dart';

class SliderView extends StatefulWidget {
  const SliderView(
      {Key? key,
      required this.profilePhoto,
      required this.userName,
      this.onHomeTap,
      this.onProfileTap,
      this.onSettingsTap,
      this.onLogoutTap})
      : super(key: key);
  final void Function()? onHomeTap;
  final void Function()? onProfileTap;
  final void Function()? onSettingsTap;
  final void Function()? onLogoutTap;
  final String profilePhoto;
  final String userName;

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.primaryWhite,
      padding: context.padding.onlyTopMedium,
      child: ListView(
        children: <Widget>[
          _sizedBox(),
          CircleAvatar(
            radius: WidgetSize.avatarRadius.value,
            backgroundImage: FileImage(
              File(widget.profilePhoto),
            ),
          ),
          _sizedBox(),
          Padding(
            padding: context.padding.onlyLeftMedium,
            child: GoogleText(
              text: widget.userName,
              fontSize: WidgetSize.fontSizeBig.value,
            ),
          ),
          _sizedBox(),
          _SliderMenuView(widget: widget)
        ],
      ),
    );
  }

  SizedBox _sizedBox() {
    return SizedBox(
      height: WidgetSize.sizedBoxNormal.value,
    );
  }
}

class _SliderMenuView extends StatelessWidget {
  const _SliderMenuView({
    required this.widget,
  });

  final SliderView widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SliderMenuItem(
            title: StringConstants.iconProfile,
            iconData: Icons.person,
            onTap: widget.onProfileTap),
        _SliderMenuItem(
            title: StringConstants.iconSetting,
            iconData: Icons.settings,
            onTap: widget.onSettingsTap),
        _SliderMenuItem(
            title: StringConstants.iconLogout,
            iconData: Icons.logout,
            onTap: widget.onLogoutTap),
      ],
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function()? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GoogleText(
        text: title,
        fontSize: 16,
      ),
      leading: Icon(iconData, color: Colors.black),
      onTap: onTap,
    );
  }
}

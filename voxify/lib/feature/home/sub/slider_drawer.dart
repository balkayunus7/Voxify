import 'dart:io';

import 'package:flutter/material.dart';
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
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage:FileImage(
                File(widget.profilePhoto),
              )
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.userName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SliderMenuItem(
              title: 'Home', iconData: Icons.abc, onTap: widget.onHomeTap),
          _SliderMenuItem(
              title: 'Profile',
              iconData: Icons.abc,
              onTap: widget.onProfileTap),
          _SliderMenuItem(
              title: 'Settings',
              iconData: Icons.abc,
              onTap: widget.onSettingsTap),
          _SliderMenuItem(
              title: 'Logout', iconData: Icons.abc, onTap: widget.onLogoutTap),
        ],
      ),
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
      ),
      leading: Icon(iconData, color: Colors.black),
      onTap: onTap,
    );
  }
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}

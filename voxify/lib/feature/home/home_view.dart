import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import 'package:voxify/product/widgets/appbar/custom_loading.dart';
import 'package:voxify/product/widgets/appbar/custom_sizedbox_shrink.dart';
import 'package:voxify/product/widgets/texts/title_text.dart';
import '../../product/models/users.dart';
import '../../product/widgets/texts/google_fonts.dart';
import 'mixin/home_view_mixin.dart';
import 'sub/slider_drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with HomeViewMixin {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    // variables for home page in mixin
    final Users? currentUser = getCurrentUser();
    final users = getUsers();
    final currentUserId = getCurrentUserId();
    if (currentUser != null) {
      return Scaffold(
        body: Padding(
          padding: context.padding.onlyTopNormal,
          // Slider Drawer
          child: SliderDrawer(
            appBar: const SliderAppBar(
                appBarColor: ColorConstants.primaryWhite,
                title: TitleText(
                    title: StringConstants.appName,
                    color: ColorConstants.primaryDark)),
            key: _sliderDrawerKey,
            sliderOpenSize: WidgetSize.sliderOpenSize.value,
            slider: SliderView(
              profilePhoto: currentUser.profilePhoto.toString(),
              userName: currentUser.name.toString(),
              // on profile tap function
              onProfileTap: onProfileTap,
            ),
            child: _UserListView(
              users,
              currentUserId,
              onChatTap,
            ),
          ),
        ),
      );
    }
    return const LoadingWidget();
  }
}

class _UserListView extends StatelessWidget {
  const _UserListView(
    this.users,
    this.currentUserId,
    this.onTap,
  );

  final List<Users>? users;
  final String currentUserId;
  final void Function(String, String)? onTap;

  @override
  Widget build(BuildContext context) {
    if (users != null) {
      return ListView.builder(
          itemCount: users!.length,
          itemBuilder: (context, index) {
            final user = users![index];
            if (user.id == currentUserId) {
              return const SizedBoxShrink();
            }
            return GestureDetector(
              onTap: () => onTap!(user.email.toString(), user.id.toString()),
              child: ListTile(
                title: GoogleText(
                  text: user.email.toString(),
                  fontSize: WidgetSize.fontSizeNormal.value,
                ),
                subtitle: GoogleText(
                  text: user.name.toString(),
                  fontSize: WidgetSize.fontSizeNormal.value,
                ),
                leading: CircleAvatar(
                  radius: WidgetSize.avatarRadius.value,
                  backgroundImage: FileImage(
                    File(user.profilePhoto.toString()),
                  ),
                ),
              ),
            );
          });
    }
    return const LoadingWidget();
  }
}

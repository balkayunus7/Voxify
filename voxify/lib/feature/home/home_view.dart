import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/chat_view.dart';
import 'package:voxify/feature/home/providers/home_notifier.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import 'package:voxify/product/widgets/texts/title_text.dart';
import '../../product/models/users.dart';
import '../../product/widgets/texts/google_fonts.dart';
import '../profile/profile_view.dart';
import 'sub/slider_drawer.dart';

final _homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  void initState() {
    super.initState();
    ref.read(_homeNotifier.notifier).fetchUsers();
    ref.read(_homeNotifier.notifier).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final Users? currentUser = ref.watch(_homeNotifier).currentUser;
    if (currentUser != null) {
      return Scaffold(
        body: Padding(
          padding: context.padding.onlyTopNormal,
          child: SliderDrawer(
              appBar: const SliderAppBar(
                  appBarColor: Colors.white,
                  title: TitleText(
                      title: StringConstants.appName,
                      color: ColorConstants.primaryDark)),
              key: _sliderDrawerKey,
              sliderOpenSize: WidgetSize.sliderOpenSize.value,
              slider: SliderView(
                profilePhoto: currentUser.profilePhoto.toString(),
                userName: currentUser.name.toString(),
                onProfileTap: () {
                  context.route.navigateToPage(const UserManagementPage());
                },
              ),
              child: const _UserListView()),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}

class _UserListView extends ConsumerWidget {
  const _UserListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(_homeNotifier).user;
    final currentUserId = ref.watch(_homeNotifier.notifier).currentUserId;
    if (users == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          if (user.id == currentUserId) {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () => context.route.navigateToPage(ChatPage(
              receiverEmail: user.email.toString(),
              receiverId: user.id.toString(),
            )),
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
                  File(user.profilePhoto ?? ''),
                ),
              ),
            ),
          );
        });
  }
}

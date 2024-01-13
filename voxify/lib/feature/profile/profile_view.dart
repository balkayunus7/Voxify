import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/home/home_view.dart';

import '../../product/constants/color_constants.dart';
import '../../product/constants/string_constants.dart';
import '../../product/widgets/appbar/custom_appbar.dart';
import 'providers/profile_provider.dart';

// * State notifier provider created to be used in the profile page
final profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage> {
  final TextEditingController _nameController =
      TextEditingController(text: StringConstants.userTextfield);

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profilProvider.notifier).getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(profilProvider).currentUser;
    if (currentUser != null) {
      return Scaffold(
          appBar: CustomAppBar(
            StringConstants.userManagementTitle,
            icon: Icons.arrow_back_ios,
            onPressed: () {
              context.route.pop();
            },
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: const SizedBox.shrink(),
          ),
          body: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(
                  File(currentUser.profilePhoto ?? ''),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    ref.watch(profilProvider.notifier).pickImage();
                  },
                  child: Text(StringConstants.userManagementButton,
                      style: context.general.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Padding(
                padding: context.padding.normal,
                child: _CustomStatTextfield(
                  labelText: StringConstants.userManagementName,
                  onPressed: () {},
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: context.padding.onlyTopNormal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: context.padding.horizontalNormal,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryGreenDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (_nameController.text.isNotEmpty) {
                            ref
                                .watch(profilProvider.notifier)
                                .changeUsername(_nameController.text)
                                .then((value) => context.route
                                    .navigateToPage(const HomePage()));
                          }
                          notEmptyDialog(context);
                        },
                        child: Text(StringConstants.userManagementEdit,
                            style: context.general.textTheme.bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primaryWhite)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<dynamic> notEmptyDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              StringConstants.userManageText,
              style: TextStyle(color: ColorConstants.primaryGreenDark),
            ),
            content: Text(StringConstants.userNotEmptyDialog),
          );
        });
  }
}

class _CustomStatTextfield extends ConsumerWidget {
  const _CustomStatTextfield(
      {required this.labelText,
      required this.onPressed,
      required this.controller});

  final String labelText;
  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: '$labelText :',
        labelStyle: context.general.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

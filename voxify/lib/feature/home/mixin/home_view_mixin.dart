import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/chat_view.dart';
import 'package:voxify/feature/profile/profile_view.dart';
import '../../../product/models/users.dart';
import '../home_view.dart';
import '../providers/home_notifier.dart';

mixin HomeViewMixin on ConsumerState<HomePage> {
  // init state
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).fetchUsers();
    ref.read(homeProvider.notifier).getCurrentUser();
  }

  // routing functions
  void onProfileTap() {
    context.route.navigateToPage(const UserManagementPage());
  }

  // ignore: body_might_complete_normally_nullable
  void Function(String, String)? onChatTap(
      String receiverEmail, String receiverId) {
    setState(() {
      context.route.navigateToPage(ChatPage(
        receiverEmail: receiverEmail,
        receiverId: receiverId,
      ));
    });
  }

  // get functions from firebase with
  Users? getCurrentUser() {
    return ref.watch(homeProvider).currentUser;
  }

  List<Users>? getUsers() {
    return ref.watch(homeProvider).user;
  }

  dynamic getCurrentUserId() {
    return ref.watch(homeProvider.notifier).currentUserId;
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

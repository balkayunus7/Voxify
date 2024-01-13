
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/chat_view.dart';
import 'package:voxify/feature/home/providers/home_notifier.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import '../../product/constants/string_constants.dart';
import '../../product/widgets/texts/google_fonts.dart';

final _homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(_homeNotifier.notifier).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        StringConstants.appName,
        icon: Icons.perm_identity,
        preferredSize: const Size.fromHeight(kToolbarHeight),
        onPressed: () {},
        child: const SizedBox.shrink(),
      ),
      body: const _UserListView(),
    );
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
                ),
                subtitle: GoogleText(
                  text: user.name.toString(),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePhoto.toString(),
                  ),
                )),
          );
        });
  }
}

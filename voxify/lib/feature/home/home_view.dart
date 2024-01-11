import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/chat_view.dart';
import 'package:voxify/feature/home/cubits/home_cubit.dart';
import 'package:voxify/product/models/users.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import '../../product/constants/string_constants.dart';
import '../../product/widgets/texts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          StringConstants.appName,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          onPressed: () {},
          child: const SizedBox.shrink(),
        ),
        body: const _UserListView(),
      ),
    );
  }
}

class _UserListView extends StatefulWidget {
  const _UserListView();

  @override
  State<_UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<_UserListView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, List<Users>>(
      selector: (state) {
        return state.user ?? [];
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.route.navigateToPage(ChatPage(
                  receiverEmail: state[index].email.toString(),
                  receiverId: state[index].id.toString(),
                )),
                child: ListTile(
                    title: GoogleText(
                      text: state[index].name.toString(),
                    ),
                    subtitle: GoogleText(
                      text: state[index].email.toString(),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        state[index].profilePhoto.toString(),
                      ),
                    )),
              );
            });
      },
    );
  }
}

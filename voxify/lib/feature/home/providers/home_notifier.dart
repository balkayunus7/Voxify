// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voxify/product/utilites/firebase/firebase_utility.dart';
import '../../../product/models/users.dart';
import '../../../product/utilites/firebase/firebase_collections.dart';

class HomeNotifier extends StateNotifier<HomeState>  with FirebaseUtility{
  HomeNotifier(): super(const HomeState());

  final String _auth = FirebaseAuth.instance.currentUser!.uid;

  get currentUserId => _auth;

  Future<void> fetchUsers() async {
    final item =
        await fetchList<Users, Users>(Users(), FirebaseCollections.users);
    state = state.copyWith(user: item);
  }
}

class HomeState extends Equatable {
  const HomeState({this.user});

  final List<Users>? user;

  @override
  List<Object?> get props => [user];

  HomeState copyWith({
    List<Users>? user,
  }) {
    return HomeState(
      user: user ?? this.user,
    );
  }
}

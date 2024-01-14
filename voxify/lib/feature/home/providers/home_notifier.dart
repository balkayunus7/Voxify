// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voxify/product/utilites/firebase/firebase_utility.dart';
import '../../../product/models/users.dart';
import '../../../product/utilites/firebase/firebase_collections.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  final String _auth = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  get currentUserId => _auth;

  Future<void> fetchUsers() async {
    final item =
        await fetchList<Users, Users>(Users(), FirebaseCollections.users);
    state = state.copyWith(user: item);
  }

  // Method to get current user
  Future<void> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    // if user is not null then get user document from firestore
    if (user != null) {
      final userUid = user.uid;
      final userDocument = await firestore
          .collection(FirebaseCollections.users.name)
          .doc(userUid)
          .get();

      if (userDocument.exists) {
        final item = Users().fromJson(userDocument.data()!);
        state = state.copyWith(currentUser: item);
      } else {
        return;
      }
    }
  }
  void logout() {
    FirebaseAuth.instance.signOut();
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.user,
    this.currentUser,
  });

  final List<Users>? user;
  final Users? currentUser;

  @override
  List<Object?> get props => [user, currentUser];

  HomeState copyWith({
    List<Users>? user,
    Users? currentUser,
  }) {
    return HomeState(
      user: user ?? this.user,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxify/product/utilites/firebase/firebase_utility.dart';
import '../../../product/models/users.dart';
import '../../../product/utilites/firebase/firebase_collections.dart';

class HomeCubit extends Cubit<HomeState> with FirebaseUtility {
  HomeCubit() : super(const HomeState());

  Future<void> fetchUsers() async {
    final item =
        await fetchList<Users, Users>(Users(), FirebaseCollections.users);

    if (item != null && item.isNotEmpty) {
      emit(state.copyWith(user: item));
    } 
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voxify/feature/auth/logics/firebase_auth.dart';
import 'package:voxify/feature/auth/logics/firestore_auth.dart';
import 'package:voxify/product/utilites/firebase/firebase_collections.dart';
import '../../../product/constants/color_constants.dart';
import '../../../product/enums/widget_sizes.dart';

class AuthNotifier extends ChangeNotifier {
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final FirestoreService firestoreService = FirestoreService();
  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;

  void logout() {
    firebaseAuthService.signOutUser();
  }

  void errorMessage(BuildContext context, e, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorConstants.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: WidgetSizeConstants.borderRadiusNormal,
        ),
        showCloseIcon: true,
        onVisible: () {
          Future.delayed(const Duration(seconds: 5), () {
            ScaffoldMessenger.of(context).clearSnackBars();
          });
        },
      ),
    );
  }

  Future<UserCredential?> loginUserWithFirebase(
      String email, String password) async {
    try {
      _userCredential =
          await firebaseAuthService.loginUserWithFirebase(email, password);
      // Return user credentials
      return _userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserCredential?> signUpUserWithFirebase(
      String email, String password, String name) async {
    _userCredential =
        await firebaseAuthService.signUpUserWithFirebase(email, password, name);
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'uid': _userCredential?.user?.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'profilePhoto':
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F5%2F50%2FUser_icon-cp.svg%2F1656px-User_icon-cp.svg.png&tbnid=ymTvsoVW55BGEM&vet=12ahUKEwio9MGi3ciDAxUA5LsIHeaUCmIQMygDegQIARBM..i&imgrefurl=https%3A%2F%2Ftr.m.wikipedia.org%2Fwiki%2FDosya%3AUser_icon-cp.svg&docid=AOS9XTcD93N8yM&w=1656&h=2057&q=user&client=safari&ved=2ahUKEwio9MGi3ciDAxUA5LsIHeaUCmIQMygDegQIARBM'
    };

    String uid = _userCredential!.user!.uid;
    await firestoreService.addToFirestore(
        data, FirebaseCollections.users.name, uid);
    return userCredential;
  }
}

// Define provider for AuthProvider
final authProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier());

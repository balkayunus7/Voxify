import 'package:firebase_auth/firebase_auth.dart';

import '../abstract/base_firebase_service.dart';

// Define FirebaseAuthClass which extends BaseFirebaseService
class FirebaseAuthService extends BaseFirebaseService {
  FirebaseAuth kauth = FirebaseAuth.instance;
  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final userCredentials =
        kauth.signInWithEmailAndPassword(email: email, password: password);
    // Return user credentials
    return userCredentials;
  }

  

  // Override signOutUser method
  @override
  void signOutUser() {
    kauth.signOut();
  }

  // Override signUpUserWithFirebase method
  @override
  Future<UserCredential> signUpUserWithFirebase(
      String email, String password, String username) {
    final userCredential =
        kauth.createUserWithEmailAndPassword(email: email, password: password);
    // Return user credentials
    return userCredential;
  }

  // Override isUserLoggedIn method
  @override
  bool isUserLoggedIn() {
    // Check if current user is not null
    if (kauth.currentUser != null) {
      // If not null, return true
      return true;
    } else {
      // If null, return false
      return false;
    }
  }
}

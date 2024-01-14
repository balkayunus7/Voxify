import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String appName = 'Voxify';
  static const String chatMessage = 'Message';

  // Login
  static const String login = 'Login';
  static const String register = 'Register';
  static const String welcomeBack = 'Welcome to Voxify';
  static const String continiueApp = 'Continiue to app';
  static const String hintTextEmail = 'E Mail';
  static const String hintName = 'Username';
  static const String hintTextPassword = 'Password';
  static const String routingTextLogin = 'A new Voxify user? Sign up now!';
  static const String routingTextRegister =
      'Are you already Voxify user? Sign in now!';

  // Home
  static const String homeBrowse = 'Voxify';
  static const String homeMessage = 'Discover the best cars  in our store';
  static const String homeTitle = 'Recommended ';
  static const String homeSeeAll = 'See All';
  static const String textfieldSearch = 'Search';

  // Navigation Menu
  static const String iconHome = 'Home';
  static const String iconSetting = 'Settings';
  static const String iconLogout = 'Logout';
  static const String iconProfile = 'Profile';

  // Selected Item
  static const String tagHandshake = 'Contact Dealer';
  static const String tagLocation = 'Dehli,India';
  static const String tagCarDetail = 'Car Details(Model,year...)';
  static const String tagMoneyDetail = 'EMI/LOAN';

  static const String iconText = 'Buy Now';
  static const String profileIconText = 'Edit Profile';

  // Saved Page
  static const String savedPageTitle = 'Saved Cars';
  static const String noSavedCars = 'Your cart is now empty';
  static const String noSavedMessage =
      "To fill your cart from CarStore's world full of opportunities you can start examining the products below";

  // Profile Page
  static const String profilePageTitle = 'Profile';
  static const String changePassword = 'Change Password';
  static const String themeText = 'Change Theme';
  static const String userManageText = 'User Management';
  static const String infoText = 'Information';
  static const String logoutText = 'Logout';

  // Settings Page
  static const String passworld = 'New Password';
  static const String confirmPassword = 'Confirm Password';
  static const String titlePassword = "Reset your password";
  static const String forgotPassword = "Forgot password";
  static const String titlePasswordMessage =
      "Enter your email address and we will send you a link to reset your password.";
  static const String iconPasswordtext = 'Reset Password';
  static const String passwordDialogText = "Passwords Don't Match";
  static const String passwordDialogMessage =
      'Please check your password again';

  // User Management Page
  static const String userManagementTitle = 'Edit Profile';
  static const String userManagementButton = 'Edit Profile Photo';
  static const String userManagementName = 'Name';
  static const String userManagementUsername = 'Username';
  static const String userManagementBio = 'Bio';
  static const String userManagementEdit = 'Confirm changes';
  static const String userNotEmptyDialog = 'Username cannot be empty';
  static const String userTextfield = 'Please write your new username!';
}

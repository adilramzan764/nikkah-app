import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/CustomLoader.dart';
import '../Widgets/CustomSnackBar.dart';
import '../res/components/custom_loading_dialog.dart';
import '../view/BottomNavBar/main_home_screen.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final accountLinkPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs; // Add this observable


  // Observable to track the current user
  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> loginUser(String email, String password) async {
    try {
      CustomLoader.startLoading(loadingStatus: 'Signing in...');

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // await _saveUserLogin(userCredential.user!);
        CustomLoader.stopLoading();
        Get.offAll(() => MainHomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      CustomLoader.stopLoading();

      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address. Please try again.';
          break;
        case 'invalid-credential':
          errorMessage = 'Incorrect email or password. Please try again.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        default:
          errorMessage = 'Login failed. Please try again.';
      }

      log("Error during login: ${e.code} - ${e.message}");
      Customsnackbar.showSnackbar(
          title: 'Error', message: errorMessage, context: Get.context!);
    } catch (e) {
      CustomLoader.stopLoading();
      log("Unexpected error: $e");
      Customsnackbar.showSnackbar(title: 'Error',
          message: 'Something went wrong. Please try again.',
          context: Get.context!);
    }
  }


  Future<UserCredential?> signInWithGoogle() async {
    try {
      _auth.signOut();
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      CustomLoader.startLoading(loadingStatus: 'Signing in...');

      if (googleUser == null) {
        debugPrint("Google Sign-In was canceled by the user.");
        CustomLoader.stopLoading();
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Check if an account with the same email already exists
      final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(googleUser.email);
      print('sign in methods:' + signInMethods.toString());

      if(signInMethods.contains('google.com') && signInMethods.contains('password')){
        UserCredential userCredential = await _auth.signInWithCredential(googleCredential);

        if (userCredential.user != null) {
          await _saveUserLogin(userCredential.user!);
          // await _saveUserToFirestore(userCredential.user!);
          Get.offAll(() => MainHomeScreen());
        }

        CustomLoader.stopLoading();
        return userCredential;
      }

      else if (signInMethods.contains(EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD)) {
        // If the email already exists with password, ask user to sign in with password first
        CustomLoader.stopLoading();

        // This is a dialog to ask user to sign in with email/password first
        bool shouldProceed = await _showAccountLinkDialog(googleUser.email);

        if (shouldProceed) {
          // User wants to link accounts - they need to sign in with email/password first
          Get.toNamed(RoutesName.linkGoogleAccountScreen,arguments: {'email': googleUser.email});
          return null;
        } else {
          // User decided not to link accounts
          return null;
        }
      }

      else {
        // No existing email-password and Google SignIn account, show error
        CustomLoader.stopLoading();

        Customsnackbar.showSnackbar(title: 'Error', message: 'Email not registered!', context: Get.context!);

        return null;
      }
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      CustomLoader.stopLoading();
      Customsnackbar.showSnackbar(
        title: 'Error',
        message: 'Something went wrong during Google Sign-In. Please try again.',
        context: Get.context!,
      );
      return null;
    }
  }


  Future<bool> _showAccountLinkDialog(String email) async {
    return await Get.dialog<bool>(
      CupertinoAlertDialog(
        title: Text('Account Exists'),
        content: Text('An account with email $email already exists. Would you like to link your Google account to it?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Get.back(result: false),
          ),
          CupertinoDialogAction(
            child: Text('Link Accounts'),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<void> linkGoogleAccount(String email, String password) async {
    try {
      CustomLoader.startLoading(loadingStatus: 'Linking account...');
      _auth.signOut();

      // Ensure user is signed in
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user == null) {
        CustomLoader.stopLoading();
        Customsnackbar.showSnackbar(
          title: 'Error',
          message: 'Something went wrong. Try again',
          context: Get.context!,
        );
        return;
      }

      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        CustomLoader.stopLoading();
        return;
      }

      // Verify emails match to prevent linking different accounts
      if (user.email != null && user.email != googleUser.email) {
        CustomLoader.stopLoading();
        Customsnackbar.showSnackbar(
          title: 'Error',
          message: 'The Google account email (${googleUser.email}) does not match your current account (${user.email}).',
          context: Get.context!,
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Link the Google credential to the current user
      await user.linkWithCredential(googleCredential);

      CustomLoader.stopLoading();
      Get.toNamed(RoutesName.loginCScreen);
      Customsnackbar.showSnackbar(
        title: 'Success',
        message: 'Google account linked successfully!',
        context: Get.context!,
      );
    } on FirebaseAuthException catch (e) {
      CustomLoader.stopLoading();

      String errorMessage;
      if (e.code == 'provider-already-linked') {
        errorMessage = 'This Google account is already linked to your account.';
      } else if (e.code == 'credential-already-in-use') {
        errorMessage = 'This Google account is already linked to another account.';
      } else {
        errorMessage = 'Error linking account: ${e.message}';
      }

      Customsnackbar.showSnackbar(
        title: 'Error',
        message: errorMessage,
        context: Get.context!,
      );
    } catch (e) {
      CustomLoader.stopLoading();
      Customsnackbar.showSnackbar(
        title: 'Error',
        message: 'Something went wrong while linking accounts.',
        context: Get.context!,
      );
    }
  }

  Future<void> _saveUserLogin(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
    await prefs.setString('email', user.email ?? '');
    await prefs.setBool('isLoggedIn', true);

  }



}
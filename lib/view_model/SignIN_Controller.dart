import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/CustomLoader.dart';
import '../Widgets/CustomSnackBar.dart';
import '../res/components/custom_loading_dialog.dart';
import '../view/BottomNavBar/main_home_screen.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final email = TextEditingController(text: 'adilramzan764@gmail.com');
  final password = TextEditingController(text: 'pakistan1@');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
    try {
      CustomLoader.startLoading(loadingStatus: 'Signing in...');

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _saveUserLogin(userCredential.user!);
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
      // Start the Google sign-in flow
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      CustomLoader.startLoading(loadingStatus: 'Signing in...');


      if (googleUser == null) {
        debugPrint("Google Sign-In was canceled by the user.");
        CustomLoader.stopLoading();
        return null; // User canceled the sign-in
      }

      // Obtain authentication details from Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
        if (!userDoc.exists) {
          Customsnackbar.showSnackbar(
            title: 'Error',
            message: 'Email is not registered',
            context: Get.context!,
          );
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
          CustomLoader.stopLoading();
          return null;
        }
        await _saveUserLogin(userCredential.user!);
        Get.offAll(() => MainHomeScreen());
      }

      CustomLoader.stopLoading();
      return userCredential;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      CustomLoader.stopLoading();
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Ensure the previous session is cleared

      await FacebookAuth.instance.logOut();

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: Platform.isAndroid
            ? LoginBehavior.nativeWithFallback
            : LoginBehavior.webOnly,
      );

      if (result.status != LoginStatus.success) {
        debugPrint("Login failed: ${result.status}");
        return null;
      }

      final OAuthCredential credential =
      FacebookAuthProvider.credential(result.accessToken!.tokenString);

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _saveUserLogin(userCredential.user!);
        Get.offAll(() => MainHomeScreen());
      }

      // Save user to Firestore
      await _saveUserToFirestore(userCredential.user!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("Auth Error: ${e.code} - ${e.message}");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  Future<void> _saveUserLogin(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
    await prefs.setString('email', user.email ?? '');
    await prefs.setBool('isLoggedIn', true);

  }


  Future<void> _saveUserToFirestore(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'fullName': user.displayName,
      'photoURL': user.photoURL,
      // 'lastLogin': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
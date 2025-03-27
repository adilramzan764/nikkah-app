import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Widgets/CustomLoader.dart';
import '../Widgets/CustomSnackBar.dart'; // Import CustomSnackBar
import '../view/SignUp/location_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();

  var verificationId = ''.obs;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void registerUser() async {
    String userEmail = email.text.trim();
    String userPassword = password.text.trim();
    String userFullName = fullName.text.trim();

    CustomLoader.startLoading(loadingStatus: "Registering User..");
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      // Store additional user data in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "fullName": userFullName,
        "email": userEmail,
        'signInMethod': 'email', // Make sure to update based on sign-in method
        'createdAt': Timestamp.now(),
      });

      log("User registered successfully");
      CustomLoader.stopLoading();
      Get.to(() =>  LocationScreen(isSignUp: true,));
    } on FirebaseAuthException catch (e) {
      CustomLoader.stopLoading();

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use. Please try another email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid. Please enter a valid email.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Please enter a stronger password.';
          break;
        default:
          errorMessage = 'Registration failed. Please try again.';
      }

      log("Error in registration: ${e.code} - ${e.message}");
      Customsnackbar.showSnackbar(
        title: 'Error',
        message: errorMessage,
        context: Get.context!,
      );
    } catch (e) {
      CustomLoader.stopLoading();
      log("Unexpected error: $e");
      Customsnackbar.showSnackbar(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
        context: Get.context!,
      );
    }
  }

  Future<void> signupWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      _auth.signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      CustomLoader.startLoading(loadingStatus: "Registering User..");

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          Customsnackbar.showSnackbar(title: 'Error', message: 'User already exists with this email address', context: Get.context!);
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
        } else {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'fullName': user.displayName,
            'email': user.email,
            'signInMethod': 'google', // Make sure to update based on sign-in method
            'createdAt': Timestamp.now(),
          }, SetOptions(merge: true));
          Get.to(() =>  LocationScreen(isSignUp: true,));

        }

        CustomLoader.stopLoading();
      }

    } catch (e) {
      Get.snackbar("Error", "Failed to sign in: $e");
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      CustomLoader.startLoading(loadingStatus: "Sending OTP..");
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Verification completed');
          // Get.offAllNamed('/home'); // Navigate to home screen
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomLoader.stopLoading();
          Get.snackbar('Error', e.message ?? 'Verification failed',
              backgroundColor: Colors.red, colorText: Colors.white);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          CustomLoader.stopLoading();
          print('OTP sent');
          // Get.toNamed('/otp'); // Navigate to OTP screen
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      CustomLoader.stopLoading();
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Function to verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      CustomLoader.startLoading(loadingStatus: "Verifying OTP..");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      CustomLoader.stopLoading();
      Get.offAllNamed('/home'); // Navigate to home screen
    } catch (e) {
      CustomLoader.stopLoading();
      Get.snackbar('Error', 'Invalid OTP', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}


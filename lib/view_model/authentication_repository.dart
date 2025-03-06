import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkah_app/view/LogIn/SignIn_Screen.dart';

import 'package:nikkah_app/view/OnboardingScreens/login_a_screen.dart';
import 'package:nikkah_app/view/OnboardingScreens/onboarding_screen.dart';
import 'package:nikkah_app/view/SignUp/location_screen.dart';
import 'package:nikkah_app/view/BottomNavBar/main_home_screen.dart';
import 'firebase_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var verificationId = ''.obs;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// **Determine Initial Screen Based on User Authentication**
  void _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LogInAScreen());
    } else {
      bool isNewUser = user.metadata.creationTime
          ?.isAfter(user.metadata.lastSignInTime!.subtract(const Duration(minutes: 1))) ??
          false;

      if (isNewUser) {
        Get.offAll(() => OnboardingScreen());
      } else {
        Get.offAll(() => MainHomeScreen());
      }
    }
  }


  /// **Sign in with Google**
  Future<UserCredential> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Ensure previous session is cleared
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google Sign-In canceled by user");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User user = userCredential.user!;

      // Save user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': user.displayName ?? "No Name",
        'email': user.email ?? "No Email",
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Navigate if the user is new
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        Get.offAll(() =>  LocationScreen(isSignUp: true,));
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      final ex = SignInGoogleFailure.code(e.code);
      log('FIREBASE AUTH EXCEPTION - ${e.message}');
      throw ex;
    } catch (_) {
      const ex = SignInGoogleFailure();
      log('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  /// **Phone Authentication**
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        String message = "Something went wrong. Try again.";
        if (e.code == 'invalid-phone-number') {
          message = 'The provided phone number is not valid.';
        } else if (e.code == 'too-many-requests') {
          message = 'Too many requests. Try again later.';
        } else if (e.code == 'quota-exceeded') {
          message = 'SMS quota exceeded. Try again later.';
        }
        Get.snackbar('Error', message);
        log("FirebaseAuthException: $e");
      },
    );
  }

  /// **Verify OTP**
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );

      if (credentials.user != null) {
        if (credentials.additionalUserInfo?.isNewUser ?? false) {
          Get.offAll(() =>  LocationScreen(isSignUp: true,));
        }
        return true;
      }
      return false;
    } catch (e) {
      log("Error verifying OTP: $e");
      return false;
    }
  }

  /// **Create User with Email & Password**
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Get.offAll(() => const LocationScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpEmailPasswordFailure.code(e.code);
      log('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpEmailPasswordFailure();
      log('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  /// **Login with Email & Password**
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignInEmailPasswordFailure.code(e.code);
      log('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignInEmailPasswordFailure();
      log('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  /// **Save User Details to Firestore**
  Future<void> saveUserDetails(String userId, String fullName, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'fullName': fullName,
        'email': email,
        'createdAt': Timestamp.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      log("Error saving user details: $e");
    }
  }

  /// **Logout User**
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } catch (e) {
      log("Error during logout: $e");
    }
  }
}

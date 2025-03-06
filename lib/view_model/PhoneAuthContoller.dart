import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes_name.dart';

class PhoneAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;
  final RxString verificationId = ''.obs;
  final RxBool canResend = true.obs;
  Timer? _resendTimer;
  int _resendTimeout = 60; // Cooldown period in seconds

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  Future<void> sendOTP(String phoneNumber) async {
    if (!canResend.value) {
      Get.snackbar('Wait', 'Resend available in $_resendTimeout seconds',
          backgroundColor: Colors.blue, colorText: Colors.white);
      return;
    }

    if (!_validatePhoneNumber(phoneNumber)) return;

    try {
      isLoading.value = true;
      _startResendCooldown();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: _handleVerificationComplete,
        verificationFailed: _handleVerificationError,
        codeSent: _handleCodeSent,
        codeAutoRetrievalTimeout: (vId) => verificationId.value = vId,
      );
    } catch (e) {
      isLoading.value = false;
      _handleAuthError(e);
    }
  }

  bool _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty || !phoneNumber.startsWith('+')) {
      Get.snackbar('Error', 'Enter valid number with country code (+)',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    // Add more validation if needed
    if (phoneNumber.length < 10) {
      Get.snackbar('Error', 'Number too short',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    return true;
  }

  void _startResendCooldown() {
    canResend.value = false;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimeout > 0) {
        _resendTimeout--;
      } else {
        _resendTimeout = 60;
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void _handleVerificationComplete(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      Get.offAllNamed(RoutesName.homeScreen);
    } catch (e) {
      _handleAuthError(e);
    }
  }

  void _handleCodeSent(String vId, int? resendToken) {
    verificationId.value = vId;
    isLoading.value = false;
    Get.toNamed(RoutesName.phoneOtpScreen); // Navigate to OTP screen
  }

  void _handleVerificationError(FirebaseAuthException error) {
    isLoading.value = false;
    log('Verification Error: ${error.code} - ${error.message}');

    if (error.code == 'too-many-requests') {
      Get.snackbar('Blocked', 'Too many attempts. Wait 24 hours.',
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', error.message ?? 'Verification failed',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _handleAuthError(dynamic e) {
    log('Auth Error: $e');

    if (e is FirebaseAuthException && e.code == 'too-many-requests') {
      Get.snackbar('Blocked', 'Too many attempts. Wait 24 hours.',
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Add this for OTP verification
  Future<void> verifyOTP(String smsCode) async {
    try {
      isLoading.value = true;
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      Get.offAllNamed(RoutesName.homeScreen);
    } catch (e) {
      _handleAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }
}
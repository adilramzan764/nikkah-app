import 'package:get/get.dart';
import '../model/otp_model.dart';
import '../view/SignUp/location_screen.dart';
import '../model/location_model.dart';
import 'package:flutter/material.dart';
import '../res/components/custom_success_dialog.dart';

class OtpViewModel extends GetxController {
  var otpInput = ''.obs;
  var resendTimer = 30.obs;
  final OtpModel otpModel = OtpModel(phoneNumber: '+92 3099368018');

  List<TextEditingController> textControllers =
  List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void onClose() {
    // Dispose controllers and focus nodes
    for (var controller in textControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void updateOtpInput() {
    otpInput.value = textControllers.map((controller) => controller.text).join();
  }

  void startResendTimer() {
    resendTimer.value = 30;
    countdown();
  }

  void countdown() {
    if (resendTimer.value > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        resendTimer.value--;
        countdown();
      });
    }
  }

  void verifyOtp() {
    if (otpInput.value == "123456") {
      Get.dialog(
        CustomWelcomeDialog(
          onClose: () {
            Get.back();
            Get.off(() =>  LocationScreen(isSignUp: true,),
              binding: BindingsBuilder(() {
                Get.put(LocationViewModel());
              }),
            );
          },
          title: 'Welcome to the app',
          message: 'Welcome! We are exciting to be part of your dating journey.'
              ' Here we treat everyone with kindness & respect',
        ),
        barrierDismissible: false,
      );
    } else {
      Get.snackbar("Invalid OTP", "Please try again!");
    }
  }

  // Clear all OTP fields
  void clearOtp() {
    for (var controller in textControllers) {
      controller.clear();
    }
    otpInput.value = '';
    focusNodes.first.requestFocus();
  }
}
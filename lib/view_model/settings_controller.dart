import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'SignOut_Controller.dart';
import 'authentication_repository.dart';
import '../res/components/custom_settings_screen_dialog.dart';

class SettingsController extends GetxController {
  final SignOut_Controller signOut_Controller = Get.put(SignOut_Controller());

  var isSwitched = false.obs;
  var selectedInterests = <String>[].obs;
  var selectedReligions = <String>[].obs;

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.clear();
      selectedInterests.add(interest);
    }
  }

  // Check if an interest is selected
  bool isInterestSelected(String interest) {
    return selectedInterests.contains(interest);
  }

  void toggleReligion(String religion) {
    if (selectedReligions.contains(religion)) {
      selectedReligions.remove(religion);
    } else {
      selectedReligions.add(religion);
    }
  }

  bool isReligionSelected(String religion) {
    return selectedReligions.contains(religion);
  }

  void showDeleteDialog() {
    CustomDialog.show(
      icon: Icons.delete_outline,
      title: "Delete Account",
      message: "Are you sure you want to delete account?",
      cancelButtonText: "Cancel",
      confirmButtonText: "Delete",
      onConfirm: () {
        Get.back();
        Get.snackbar(
          "Account Deleted",
          "Your account has been deleted successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showLogoutDialog() {
    CustomDialog.show(
      icon: Icons.logout,
      title: "Logout",
      message: "Are you sure you want to logout?",
      cancelButtonText: "No",
      confirmButtonText: "Yes",
      onConfirm: () {
        signOut_Controller.signOut();
        // AuthenticationRepository.instance.logout();
        // Get.back();
        // Get.snackbar(
        //   "Logged Out",
        //   "You have been logged out successfully.",
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      },
    );
  }
}
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class DateOfBirthController extends GetxController {
  final dateOfBirth = Rx<DateTime?>(null);

  // Reactive TextEditingControllers
  final dayController = TextEditingController().obs;
  final yearController = TextEditingController().obs;
  final monthController = TextEditingController().obs;

  // Set date of birth
  void setDateOfBirth(DateTime date) {
    dateOfBirth.value = date;

    // Update the controllers with the selected date - now with padded values for consistent display
    dayController.value.text = date.day.toString().padLeft(2, '0');
    monthController.value.text = date.month.toString().padLeft(2, '0');
    yearController.value.text = date.year.toString();
  }

  bool canProceed() {
    return dateOfBirth.value != null;
  }


  void navigateToGenderScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.genderScreen,arguments: {'isSignUp': true});

    }
  }
  // Upload the selected date of birth to Firebase
  Future<void> uploadDateOfBirthToFirebase() async {
    if (dateOfBirth.value != null) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          // Format the date to 'YYYY-MM-DD'
          final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfBirth.value!);

          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'dateOfBirth': formattedDate,
          }, SetOptions(merge: true));
          print('Date of Birth uploaded successfully');

          // Get.snackbar(
          //   'Success',
          //   'Date of Birth uploaded successfully',
          //   snackPosition: SnackPosition.BOTTOM,
          //   duration: const Duration(seconds: 2),
          // );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to upload Date of Birth: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please select a valid Date of Birth',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Try to fetch existing date of birth data
    fetchDateOfBirth();
  }

  @override
  void onClose() {
    dayController.value.dispose();
    monthController.value.dispose();
    yearController.value.dispose();
    super.onClose();
  }

  // Fetch date of birth from Firebase if it exists
  Future<void> fetchDateOfBirth() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists && userDoc.data() is Map<String, dynamic>) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final dobString = userData['dateOfBirth'] as String?;

          if (dobString != null && dobString.isNotEmpty) {
            try {
              final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dobString);
              setDateOfBirth(parsedDate);
            } catch (e) {
              // If date parsing fails, do nothing
            }
          }
        }
      }
    } catch (e) {
      // Silently handle error to avoid disrupting the user experience
      print('Error fetching date of birth: $e');
    }
  }

  Future<void> updateDOBToFirebase(EditProfileController editProfileController,) async {
    if (canProceed()) {
      // Format the date to 'YYYY-MM-DD'
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfBirth.value!);

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'dateOfBirth': formattedDate,
      }, SetOptions(merge: true));
      editProfileController.updateField('dateOfBirth', formattedDate);
    }
  }
}
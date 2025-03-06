import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class JobTitleController extends GetxController {
  final jobTitle = ''.obs;
  final textController = TextEditingController();
  void setJobTitle(String value) {
    jobTitle.value = value;
  }

  bool canProceed() {
    return jobTitle.value.isNotEmpty;
  }

  void navigateToIntensionScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.intentionScreen, arguments: {'isSignUp': true});

    }
  }

  Future<void> uploadJobTitleToFirebase() async {
    if (jobTitle.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'jobTitle': jobTitle.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Job Title uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload Job Title: $e');
      }
    } else {
      Get.snackbar('Error', 'Job Title cannot be empty');
    }
  }

  Future<void> updateJobTitleToFirebase(EditProfileController editProfileController) async {
    if (textController.text.isNotEmpty) {
      editProfileController.updateField('jobTitle', textController.text);
    }
  }

}
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class DescriptionController extends GetxController {
  final description = ''.obs;
  final textController = TextEditingController();
  void setDescription(String value) {
    description.value = value;
  }

  bool canProceed() {
    return description.value.isNotEmpty;
  }

  void navigateToInterestsScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.interestScreen,arguments: {'isSignUp': true});

    }
  }

  Future<void> uploadDescriptionToFirebase() async {
    if (description.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'description': description.value,
          }, SetOptions(merge: true));

        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload description: $e');
      }
    } else {
      Get.snackbar('Error', 'Description cannot be empty');
    }
  }

  Future<void> updateDescriptionToFirebase(EditProfileController editProfileController) async {
    if (description.isNotEmpty) {
      editProfileController.updateField('description', description.value);
    }
  }




}
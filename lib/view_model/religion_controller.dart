import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikkah_app/view/SignUp/language_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class ReligionController extends GetxController {
  final Rx<String> selectedReligion = ''.obs;
  // var religion = ''.obs;

  void setReligion(String religion) {
    selectedReligion.value = religion;
  }

  bool canProceed() {
    return selectedReligion.value.isNotEmpty;
  }

  void navigateToLanguage() {
    if (canProceed()) {
      Get.toNamed(RoutesName.languageScreen,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadReligionToFirebase() async {
    if (selectedReligion.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedReligion': selectedReligion.value,
          }, SetOptions(merge: true));
          print('Religion uploaded successfully');
          // Get.snackbar('Success', 'Religion uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload religion: $e');
      }
    }
  }
  Future<void> updateReligionToFirebase(EditProfileController editProfileController) async {
    if (selectedReligion.isNotEmpty) {
      editProfileController.updateField('selectedReligion', selectedReligion.value);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchReligion();
  // }
  //
  // Future<void> fetchReligion() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         religion.value = userDoc['selectedReligion'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch religion: $e');
  //   }
  // }
  //
  // Future<void> updateReligion(String newReligion) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedReligion': newReligion,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       religion.value = newReligion;
  //       Get.snackbar('Success', 'Religion updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update religion: $e');
  //   }
  // }
}
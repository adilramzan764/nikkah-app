import 'package:get/get.dart';
import '../routes/routes_name.dart';
import '../view/SignUp/height_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_controller.dart';

class GenderController extends GetxController {
  final Rx<String> selectedGender = ''.obs;
  // var gender = ''.obs;

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  bool canProceed() {
    return selectedGender.value.isNotEmpty;
  }

  void navigateToHeightScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.heightScreen,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadGenderToFirebase() async {
    if (selectedGender.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedGender': selectedGender.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Gender uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload gender: $e');
      }
    }
  }


  Future<void> updateGenderToFirebase(EditProfileController editProfileController) async {
    if (selectedGender.isNotEmpty) {
      editProfileController.updateField('selectedGender', selectedGender.value);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchGender();
  // }
  //
  // Future<void> fetchGender() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         gender.value = userDoc['selectedGender'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch gender: $e');
  //   }
  // }
  //
  // Future<void> updateGender(String newGender) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedGender': newGender,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       gender.value = newGender;
  //       Get.snackbar('Success', 'Gender updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update gender: $e');
  //   }
  // }
}
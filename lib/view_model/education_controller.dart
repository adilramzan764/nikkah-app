import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nikkah_app/view/SignUp/date_of_birth_screen.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class EducationController extends GetxController {
  final Rx<String> selectedEducation = ''.obs;
  // var education = ''.obs;

  void setEducation(String education) {
    selectedEducation.value = education;
  }

  bool canProceed() {
    return selectedEducation.value.isNotEmpty;
  }

  void navigateToDateOfBirthScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.dateOfBirth,arguments: {'isSignUp': true});

    }
  }

  Future<void> uploadEducationToFirebase() async {
    if (selectedEducation.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedEducation': selectedEducation.value,
          }, SetOptions(merge: true));
          print('Education uploaded successfully');

          // Get.snackbar('Success', 'Education uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload education: $e');
      }
    }
  }
  Future<void> updateEducationToFirebase(EditProfileController editProfileController) async {
    if (selectedEducation.isNotEmpty) {
      editProfileController.updateField('selectedEducation', selectedEducation.value);
    }
  }


  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchEducation();
  // }
  //
  // Future<void> fetchEducation() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         education.value = userDoc['selectedEducation'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch education: $e');
  //   }
  // }
  //
  // Future<void> updateEducation(String newEducation) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedEducation': newEducation,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       education.value = newEducation;
  //       Get.snackbar('Success', 'Education updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update education: $e');
  //   }
  // }

}
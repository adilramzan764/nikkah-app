import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikkah_app/view/SignUp/drink_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class HeightController extends GetxController {
  final Rx<String> selectedHeight = ''.obs;
  // var height = ''.obs;

  void setHeight(String height) {
    selectedHeight.value = height;
  }

  bool canProceed() {
    return selectedHeight.value.isNotEmpty;
  }

  void navigateToDrinkScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.drinkScreen,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadHeightToFirebase() async {
    if (selectedHeight.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedHeight': selectedHeight.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Height uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload height: $e');
      }
    }
  }

  Future<void> updateHeightToFirebase(EditProfileController editProfileController) async {
    if (selectedHeight.isNotEmpty) {
      editProfileController.updateField('selectedHeight', selectedHeight.value);
    }
  }



}
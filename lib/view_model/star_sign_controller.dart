import 'package:get/get.dart';
import '../routes/routes_name.dart';
import '../view/SignUp/personality_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_controller.dart';

class StarSignController extends GetxController {

  final Rx<String> selectedStarSign = ''.obs;
  // var starSign = ''.obs;

  void setStarSign(String starSign) {
    selectedStarSign.value = starSign;
  }

  bool canProceed() {
    return selectedStarSign.value.isNotEmpty;
  }

  void navigateToPersonalityScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.personalityScreen,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadStarSignToFirebase() async {
    if (selectedStarSign.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedStarSign': selectedStarSign.value,
          }, SetOptions(merge: true));

        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload StarSign: $e');
      }
    }
  }
  Future<void> updateStarSignToFirebase(EditProfileController editProfileController) async {
    if (selectedStarSign.isNotEmpty) {
      editProfileController.updateField('selectedStarSign', selectedStarSign.value);
    }
  }

}
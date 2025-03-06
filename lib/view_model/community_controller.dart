import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkah_app/view/SignUp/education_screen.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class CommunityController extends GetxController {
  final Rx<String> selectedCommunity = ''.obs;
  // var community = ''.obs;

  void setCommunity(String community) {
    selectedCommunity.value = community;
  }

  bool canProceed() {
    return selectedCommunity.value.isNotEmpty;
  }

  void navigateToEducation() {
    if (canProceed()) {
      Get.toNamed(RoutesName.educationScreen,arguments: {'isSignUp': true});

    }
  }

  Future<void> uploadCommunityToFirebase() async {
    if (selectedCommunity.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedCommunity': selectedCommunity.value,
          }, SetOptions(merge: true));
          print('Community uploaded successfully');

          // Get.snackbar('Success', 'Community uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload Community: $e');
      }
    }
  }
  Future<void> updateCommunityToFirebase(EditProfileController editProfileController) async {
    if (selectedCommunity.isNotEmpty) {
      editProfileController.updateField('selectedCommunity', selectedCommunity.value);
    }
  }

}
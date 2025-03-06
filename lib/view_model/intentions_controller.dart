import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkah_app/view/SignUp/image_selection_screen.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class IntentionController extends GetxController {
  final Rx<String> selectedIntention = ''.obs;
  // var intentions = ''.obs;

  void setIntention(String intention) {
    selectedIntention.value = intention;
  }

  bool canProceed() {
    return selectedIntention.value.isNotEmpty;
  }

  void navigateToImagePickerScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.addphotos_Screen);
    }
  }

  Future<void> uploadIntentionToFirebase() async {
    if (selectedIntention.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedIntention': selectedIntention.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Intentions uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload intentions: $e');
      }
    }
  }


  Future<void> updateIntensionsToFirebase(EditProfileController editProfileController) async {
    if (selectedIntention.isNotEmpty) {
      editProfileController.updateField('selectedIntention', selectedIntention.value);
    }
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchIntentions();
  // }
  //
  // Future<void> fetchIntentions() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         intentions.value = userDoc['selectedIntention'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch intentions: $e');
  //   }
  // }
  //
  // Future<void> updateIntentions(String newIntentions) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedIntention': newIntentions,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       intentions.value = newIntentions;
  //       Get.snackbar('Success', 'Intentions updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update intentions: $e');
  //   }
  // }
}
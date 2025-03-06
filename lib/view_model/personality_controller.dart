import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkah_app/Widgets/CustomSnackBar.dart';
import 'package:nikkah_app/view/SignUp/description_screen.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class PersonalityController extends GetxController {

  final RxList<String> selectedPersonalities = <String>[].obs;
  // final RxList<String> personalities = <String>[].obs;

  void togglePersonality(String personality) {
    if (selectedPersonalities.contains(personality)) {
      selectedPersonalities.remove(personality);
    } else {
      selectedPersonalities.add(personality);
    }
  }

  // Check if at least one personality is selected
  bool canProceed() {
    return selectedPersonalities.isNotEmpty;
  }

  // Navigate to the community screen
  void navigateToDescriptionScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.descriptionScreen, arguments: {'isSignUp': true});
    }
  }

  // Upload the selected Personalities to Firebase
  Future<void> uploadPersonalitiesToFirebase() async {
    if (selectedPersonalities.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedPersonalities': selectedPersonalities,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Personalities uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload Personalities: $e');
      }
    }
  }

  Future<void> updatePersonalitiesToFirebase(EditProfileController editProfileController) async {
    if (selectedPersonalities.isNotEmpty) {
      // Convert the list to a comma-separated string
      String personalaitiesAsString = selectedPersonalities.join(', ');
      editProfileController.updateField('selectedPersonalities', personalaitiesAsString);
    }
    else{
      Customsnackbar_SignUpScreens.showSnackbar(message: 'Please select atleast one personaly', context: Get.context!);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchPersonalities();
  // }
  //
  // Future<void> fetchPersonalities() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         List<dynamic>? fetchedPersonalities = userDoc['selectedPersonalities'];
  //         if (fetchedPersonalities != null) {
  //           personalities.assignAll(fetchedPersonalities.cast<String>());
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch Personalities: $e');
  //   }
  // }
  //
  // Future<void> updatePersonalities(String newPersonalities) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       List<String> languageList =
  //       newPersonalities.split(',').map((e) => e.trim()).toList(); // Convert string to list
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedPersonalities': languageList,
  //       }, SetOptions(merge: true));
  //
  //       personalities.assignAll(languageList); // Update local list
  //       Get.snackbar('Success', 'Personalities updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update Personalities: $e');
  //   }
  // }

}
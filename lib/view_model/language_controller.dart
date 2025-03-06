import 'package:get/get.dart';
import '../routes/routes_name.dart';
import '../view/SignUp/community_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_controller.dart';

class LanguageController extends GetxController {

  final RxList<String> selectedLanguages = <String>[].obs;
  // final RxList<String> languages = <String>[].obs;

  void toggleLanguage(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
  }

  // Check if at least one language is selected
  bool canProceed() {
    return selectedLanguages.isNotEmpty;
  }

  // Navigate to the community screen
  void navigateToCommunity() {
    if (canProceed()) {
      Get.toNamed(RoutesName.communityScreen,arguments: {'isSignUp': true});
    }
  }

  // Upload the selected languages to Firebase
  Future<void> uploadLanguagesToFirebase() async {
    if (selectedLanguages.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedLanguages': selectedLanguages,
          }, SetOptions(merge: true));
          print('Languages uploaded successfully');

          // Get.snackbar('Success', 'Languages uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload languages: $e');
      }
    }
  }
  Future<void> updateLanguageToFirebase(EditProfileController editProfileController) async {
    if (selectedLanguages.isNotEmpty) {
      // Convert the list to a comma-separated string
      String languagesAsString = selectedLanguages.join(', ');
      editProfileController.updateField('selectedLanguages', languagesAsString);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchLanguages();
  // }
  //
  // Future<void> fetchLanguages() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         List<dynamic>? fetchedLanguages = userDoc['selectedLanguages'];
  //         if (fetchedLanguages != null) {
  //           languages.assignAll(fetchedLanguages.cast<String>());
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch languages: $e');
  //   }
  // }
  //
  // Future<void> updateLanguages(String newLanguages) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       List<String> languageList =
  //       newLanguages.split(',').map((e) => e.trim()).toList(); // Convert string to list
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedLanguages': languageList,
  //       }, SetOptions(merge: true));
  //
  //       languages.assignAll(languageList); // Update local list
  //       Get.snackbar('Success', 'Languages updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update languages: $e');
  //   }
  // }
}
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_controller.dart';

class CountryController extends GetxController {
  final selectedCountry = ''.obs;

  void setCountry(String country) {
    selectedCountry.value = country;
  }

  bool canProceed() {
    return selectedCountry.value.isNotEmpty;
  }

  Future<void> uploadCountryToFirebase() async {
    if (selectedCountry.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedCountry': selectedCountry.value,
          }, SetOptions(merge: true));
          print('Country uploaded successfully');

          // Get.snackbar('Success', 'Country uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload country: $e');
      }
    }
  }
  Future<void> updateCountryToFirebase(EditProfileController editProfileController) async {
    if (selectedCountry.isNotEmpty) {
      editProfileController.updateField('selectedCountry', selectedCountry.value);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchCountry();
  // }
  //
  // Future<void> fetchCountry() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         selectedCountry.value = userDoc['selectedCountry'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch Country: $e');
  //   }
  // }
  //
  // Future<void> updateCountry(String newCountry) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedCountry': newCountry,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       selectedCountry.value = newCountry;
  //       Get.snackbar('Success', 'Country updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update Country: $e');
  //   }
  // }
}
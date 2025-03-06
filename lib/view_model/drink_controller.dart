import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikkah_app/view/SignUp/workout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/routes_name.dart';
import 'edit_profile_controller.dart';

class DrinkController extends GetxController {

  final Rx<String> selectedDrink = ''.obs;
  // var drink = ''.obs;

  void setDrink(String drink) {
    selectedDrink.value = drink;
  }

  bool canProceed() {
    return selectedDrink.value.isNotEmpty;
  }

  void navigateToWorkoutScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.workoutScreen,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadDrinkToFirebase() async {
    if (selectedDrink.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedDrink': selectedDrink.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Drink uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload drink: $e');
      }
    }
  }

  Future<void> updateDrinkToFirebase(EditProfileController editProfileController) async {
    if (selectedDrink.isNotEmpty) {
      editProfileController.updateField('selectedDrink', selectedDrink.value);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchDrink();
  // }
  //
  // Future<void> fetchDrink() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         drink.value = userDoc['selectedDrink'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch drink: $e');
  //   }
  // }
  //
  // Future<void> updateDrink(String newDrink) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedDrink': newDrink,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       drink.value = newDrink;
  //       Get.snackbar('Success', 'Drink updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update drink: $e');
  //   }
  // }

  // final drinkPreference = ''.obs;
  //
  // void setDrinkPreference(String preference) {
  //   drinkPreference.value = preference;
  // }
  //
  // bool canProceed(String s) {
  //   return drinkPreference.value.isNotEmpty;
  // }
}
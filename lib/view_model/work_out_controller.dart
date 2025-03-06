import 'package:get/get.dart';
import '../routes/routes_name.dart';
import '../view/SignUp/star_sign_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_controller.dart';

class WorkoutController extends GetxController {
  final Rx<String> selectedWorkout = ''.obs;
  var workout = ''.obs;

  void setWorkout(String workout) {
    selectedWorkout.value = workout;
  }

  bool canProceed() {
    return selectedWorkout.value.isNotEmpty;
  }

  void navigateToStarSignScreen() {
    if (canProceed()) {
      Get.toNamed(RoutesName.starSign,arguments: {'isSignUp': true});
    }
  }

  Future<void> uploadWorkoutToFirebase() async {
    if (selectedWorkout.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'selectedWorkout': selectedWorkout.value,
          }, SetOptions(merge: true));

          // Get.snackbar('Success', 'Workout uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload workout: $e');
      }
    }
  }
  Future<void> updateWorkoutToFirebase(EditProfileController editProfileController) async {
    if (selectedWorkout.isNotEmpty) {
      editProfileController.updateField('selectedWorkout', selectedWorkout.value);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchWorkout();
  // }
  //
  // Future<void> fetchWorkout() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         workout.value = userDoc['selectedWorkout'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch Workout: $e');
  //   }
  // }
  //
  // Future<void> updateWorkout(String newWorkout) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'selectedWorkout': newWorkout,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       workout.value = newWorkout;
  //       Get.snackbar('Success', 'Workout updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update Workout: $e');
  //   }
  // }

  // final selectedWorkoutFrequency = RxString('');
  //
  // void setWorkoutFrequency(String frequency) {
  //   selectedWorkoutFrequency.value = frequency;
  // }
  //
  // bool canProceed() {
  //   return selectedWorkoutFrequency.isNotEmpty;
  // }
  // void navigateToStarSign() {
  //   if (canProceed()) {
  //     Get.off(() => StarSignScreen());
  //   }
  // }
}
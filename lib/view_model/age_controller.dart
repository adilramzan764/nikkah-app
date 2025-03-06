import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgeController extends GetxController {
  final age = ''.obs;
  final textController = TextEditingController();
  void setAge(String value) {
    age.value = value;
  }

  bool canProceed() {
    return age.value.isNotEmpty;
  }

  Future<void> uploadAgeToFirebase() async {
    if (age.value.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'age': age.value, // Upload age
          }, SetOptions(merge: true));
          Get.snackbar('Success', 'Age uploaded successfully');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload age: $e');
      }
    } else {
      Get.snackbar('Error', 'Age cannot be empty');
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchAge();
  // }
  //
  // Future<void> fetchAge() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .get();
  //
  //       if (userDoc.exists) {
  //         age.value = userDoc['age'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     log('Error: Failed to fetch age: $e');
  //   }
  // }
  //
  // Future<void> updateAge(String newAge) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .set({
  //         'age': newAge,
  //       }, SetOptions(merge: true));
  //
  //       // Update local variable
  //       age.value = newAge;
  //       // Get.find<UserProfileController>().updateFullNameLocally(newAge);
  //       Get.snackbar('Success', 'Age updated successfully');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update age: $e');
  //   }
  // }

}

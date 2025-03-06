import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nikkah_app/view_model/edit_profile_controller.dart';
import '../res/list/lists.dart';
import '../model/interest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterestsController extends GetxController {
  final int maxSelections = 10;
  final RxInt selectedCount = 0.obs;
  final RxList<String> interests = <String>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<InterestCategory> categories = <InterestCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInterests();
    // fetchInterests();
  }

  void loadInterests() {
    categories.value = InterestsList.getInterests();
  }

  void toggleInterest(Interest interest) {
    if (!interest.isSelected && selectedCount.value >= maxSelections) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'You can only select up to $maxSelections interests',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ));

      return;
    }

    interest.isSelected = !interest.isSelected;
    selectedCount.value = categories.expand((c) => c.interests).where((i) => i.isSelected).length;
    categories.refresh();
  }

  Future<void> uploadInterests(String userId) async {
    List<String> selectedInterests = categories
        .expand((c) => c.interests)
        .where((i) => i.isSelected)
        .map((i) => i.name)
        .toList();

    try {
      await _firestore.collection('users').doc(userId).set({
        'selectedInterests': selectedInterests,
      }, SetOptions(merge: true));

      // Get.snackbar('Success', 'Interests uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload interests');
    }
  }
  Future<void> updateInterestsInFirebase(EditProfileController editProfileController) async {
    List<String> selectedInterests = categories
        .expand((c) => c.interests)
        .where((i) => i.isSelected)
        .map((i) => i.name)
        .toList();

    editProfileController.updateField('selectedInterests', selectedInterests.join(', '));

  }


}
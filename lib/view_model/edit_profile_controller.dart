import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/CustomLoader.dart';
import 'image_controller.dart';
import '../model/user_profile_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/subscription_features_model.dart';
import '../res/list/subscription_features_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class EditProfileController extends GetxController {
  var user = UserProfileModel(
    age: 28,
    languages: [],
    galleryImages: [],
    name: 'John Andrew',
    subscriptionType: 'Free',
  ).obs;

  // var completionPercentage = 0.0.obs;
  var completionPercentage = (0.0).obs;
  var activeSubscriptionIndex = 0.obs;
  final subscriptionFeatures = SubscriptionFeaturesList.features.obs;

  // New variables for image stepper
  var currentStep = 0.obs;

  // New methods for image stepper
  void nextStep() {
    if (currentStep.value < user.value.galleryImages.length - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void updateGalleryImages(List<String> images) {
    user.update((val) {
      val?.galleryImages = images;
    });
    updateCompletionPercentage();
  }

  void setActiveSubscription(int index) {
    activeSubscriptionIndex.value = index;
  }

  List<SubscriptionFeature> getFeaturesForTier(String tier) {
    return subscriptionFeatures[tier.toLowerCase()] ?? [];
  }

  void handleUpgrade(String tier) {
    user.update((val) {
      val?.upgradeSubscription(tier);
    });
    log('Upgraded to $tier subscription');
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      user.update((user) {
        user?.profileImage = image.path;
      });
      updateCompletionPercentage();
    }
  }

  void updateCompletionPercentage() {
    int filledFields = 0;
    int totalFields = 21;

    if (fullName.value.isNotEmpty) filledFields++;
    if (email.value.isNotEmpty) filledFields++;
    if (age.value.isNotEmpty) filledFields++;
    if (education.value.isNotEmpty) filledFields++;
    if (drink.value.isNotEmpty) filledFields++;
    if (languages.isNotEmpty) filledFields++;
    if (jobTitle.value.isNotEmpty) filledFields++;
    if (city.value.isNotEmpty) filledFields++;
    if (interests.isNotEmpty) filledFields++;
    if (personalities.isNotEmpty) filledFields++;
    if (description.value.isNotEmpty) filledFields++;
    if (intentions.value.isNotEmpty) filledFields++;
    if (bornPlace.value.isNotEmpty) filledFields++;
    if (gender.value.isNotEmpty) filledFields++;
    if (date.value.isNotEmpty) filledFields++;
    if (selectedCountry.value.isNotEmpty) filledFields++;
    if (religion.value.isNotEmpty) filledFields++;
    if (community.value.isNotEmpty) filledFields++;
    if (height.value.isNotEmpty) filledFields++;
    if (starSign.value.isNotEmpty) filledFields++;
    if (workout.value.isNotEmpty) filledFields++;

    completionPercentage.value = (filledFields / totalFields) * 100;

    // Save to local storage
    final box = GetStorage();
    box.write("completionPercentage", completionPercentage.value);
  }

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    completionPercentage.value = box.read("completionPercentage") ?? 0.0;
    fetchUserData().then((_) {
      updateCompletionPercentage();
    });
    fetchUserImages();
    try {
      final imageController = Get.find<ImageController>();
      if (imageController.imageList.isNotEmpty) {
        updateGalleryImages(imageController.imageList);
      }
    } catch (e) {
      log("ImageController not found");
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchUserData();
  //   try {
  //     final imageController = Get.find<ImageController>();
  //     if (imageController.imageList.isNotEmpty) {
  //       updateGalleryImages(imageController.imageList);
  //     }
  //   } catch (e) {
  //     log('ImageController not found');
  //   }
  // }

  var fullName = ''.obs;
  var email = ''.obs;
  var age = ''.obs;
  var education = ''.obs;
  var drink = ''.obs;
  var languages = <String>[].obs;
  var jobTitle = ''.obs;
  var city = ''.obs;
  var interests = <String>[].obs;
  var personalities = <String>[].obs;
  var description = ''.obs;
  var intentions = ''.obs;
  var bornPlace = ''.obs;
  var gender = ''.obs;
  var date = ''.obs;
  var selectedCountry = ''.obs;
  var religion = ''.obs;
  var community = ''.obs;
  var height = ''.obs;
  var starSign = ''.obs;
  var workout = ''.obs;
  var isLoading = true.obs;

  Future<void> fetchUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>? ?? {};

          fullName.value = data['fullName'] ?? 'Unknown';
          email.value = data['email'] ?? 'No Email';
          selectedCountry.value = data['selectedCountry'] ?? '';
          religion.value = data['selectedReligion'] ?? '';
          languages.value = List<String>.from(data['selectedLanguages'] ?? []);
          community.value = data['selectedCommunity'] ?? '';
          education.value = data['selectedEducation'] ?? '';
          date.value = data['dateOfBirth'] ?? '';
          gender.value = data.containsKey('selectedGender') ? data['selectedGender'] ?? '' : '';
          height.value = data['selectedHeight'] ?? '';
          jobTitle.value = data['jobTitle'] ?? '';
          intentions.value = data['selectedIntention'] ?? '';
          drink.value = data['selectedDrink'] ?? '';
          workout.value = data['selectedWorkout'] ?? '';
          starSign.value = data['selectedStarSign'] ?? '';
          personalities.value = data.containsKey('selectedPersonalities') ?
          List<String>.from(data['selectedPersonalities'] ?? []) : [];
          description.value = data['description'] ?? '';
          interests.value = data.containsKey('selectedInterests') ?
          List<String>.from(data['selectedInterests'] ?? []) : [];
          age.value = data['age'] ?? '';
          city.value = data['currentCity'] ?? '';
          bornPlace.value = data['bornPlace'] ?? '';
          update();
        }
        // if (userDoc.exists) {
        //   fullName.value = userDoc['fullName'] ?? 'Unknown';
        //   email.value = userDoc['email'] ?? 'No Email';
        //   education.value = userDoc['selectedEducation'] ?? '';
        //   drink.value = userDoc['selectedDrink'] ?? '';
        //   languages.value = List<String>.from(userDoc['selectedLanguages'] ?? []);
        //   interests.value = List<String>.from(userDoc['selectedInterests'] ?? []);
        //   personalities.value = List<String>.from(userDoc['selectedPersonalities'] ?? []);
        //   jobTitle.value = userDoc['jobTitle'] ?? '';
        //   description.value = userDoc['description'] ?? '';
        //   intentions.value = userDoc['selectedIntention'] ?? '';
        //   gender.value = userDoc['selectedGender'] ?? '';
        //   date.value = userDoc['dateOfBirth'] ?? '';
        //   selectedCountry.value = userDoc['selectedCountry'] ?? '';
        //   religion.value = userDoc['selectedReligion'] ?? '';
        //   community.value = userDoc['selectedCommunity'] ?? '';
        //   height.value = userDoc['selectedHeight'] ?? '';
        //   starSign.value = userDoc['selectedStarSign'] ?? '';
        //   workout.value = userDoc['selectedWorkout'] ?? '';
        //   age.value =userDoc['age'] ?? '';
        //   city.value = userDoc['currentCity'] ?? '';
        //   bornPlace.value = userDoc['bornPlace'] ?? '';
        // }
      }
    } catch (e) {
      log("Error fetching user data: $e");
    } finally {
      isLoading.value = false;
      updateCompletionPercentage();
    }
  }

// Method to update any field
  Future<void> updateField(String field, String newValue) async {
    try {
      CustomLoader.startLoading(loadingStatus: 'Updating...');

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        dynamic valueToStore = newValue; // Default is string

        // Convert to list if field requires a list
        List<String> listFields = [
          'selectedLanguages',
          'selectedInterests',
          'selectedPersonalities'
        ];

        // Convert to list if field is in the listFields
        if (listFields.contains(field)) {
          valueToStore = newValue.split(',').map((e) => e.trim()).toList();
        }

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          field: valueToStore,
        }, SetOptions(merge: true));

        switch (field) {
          case 'age':
            age.value = newValue;
            break;
          case 'selectedEducation':
            education.value = newValue;
            break;
          case 'selectedDrink':
            drink.value = newValue;
            break;
          case 'jobTitle':
            jobTitle.value = newValue;
            break;
          case 'currentCity':
            city.value = newValue;
            break;
          case 'selectedLanguages':
            languages.assignAll(valueToStore);
            break;
          case 'selectedInterests':
            interests.assignAll(valueToStore);
            break;
          case 'selectedPersonalities':
            personalities.assignAll(valueToStore);
            break;
          case 'description':
            description.value = newValue;
            break;
          case 'selectedIntention':
            intentions.value = newValue;
            break;
          case 'bornPlace':
            bornPlace.value = newValue;
            break;
          case 'selectedGender':
            gender.value = newValue;
            break;
          case 'dateOfBirth':
            date.value = newValue;
            break;
          case 'selectedCountry':
            selectedCountry.value = newValue;
            break;
          case 'selectedReligion':
            religion.value = newValue;
            break;
          case 'selectedCommunity':
            community.value = newValue;
            break;
          case 'selectedHeight':
            height.value = newValue;
            break;
          case 'selectedStarSign':
            starSign.value = newValue;
            break;
          case 'selectedWorkout':
            workout.value = newValue;
            break;
        }
        CustomLoader.stopLoading();
        Get.back();
        // Fetch updated data from Firestore
        await fetchUserData();

        Get.snackbar('Success', '$field updated successfully');
        updateCompletionPercentage();

      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update $field: $e');
    }
  }

  Future<void> fetchUserImages() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        final snapshot = await databaseReference.child('user_images').child(user.uid).get();

        if (snapshot.exists) {
          final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          List<String> urls = [];
          values.forEach((key, value) {
            urls.add(value['url']);
          });
          updateGalleryImages(urls);
        }
      }
    } catch (e) {
      log('Error fetching user images: $e');
    }
  }

  Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        final snapshot = await databaseReference.child('user_images').child(user.uid).get();

        if (snapshot.exists) {
          final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          String? keyToDelete;

          values.forEach((key, value) {
            if (value['url'].trim() == imageUrl.trim()) {
              keyToDelete = key;
            }
          });

          if (keyToDelete != null) {
            await databaseReference.child('user_images').child(user.uid).child(keyToDelete!).remove();
            print('Image deleted successfully');
          } else {
            print('Image not found in the database');
          }
        } else {
          print('No images found in the database');
        }
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

}












// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import '../model/subscription_features_model.dart';
// import '../model/user_profile_model.dart';
// import '../res/list/subscription_features_list.dart';
// import 'image_controller.dart';
//
// class UserProfileController extends GetxController {
//   var user = UserProfileModel(
//     name: 'John Andrew',
//     age: 28,
//     languages: [],
//     subscriptionType: 'Free',
//     galleryImages: [],
//   ).obs;
//
//   // var completionPercentage = 0.0.obs;
//   var completionPercentage = (0.0).obs;
//   var activeSubscriptionIndex = 0.obs;
//   final subscriptionFeatures = SubscriptionFeaturesList.features.obs;
//
//   // New variables for image stepper
//   var currentStep = 0.obs;
//
//   // New methods for image stepper
//   void nextStep() {
//     if (currentStep.value < user.value.galleryImages.length - 1) {
//       currentStep.value++;
//     }
//   }
//
//   void previousStep() {
//     if (currentStep.value > 0) {
//       currentStep.value--;
//     }
//   }
//
//   void updateGalleryImages(List<String> images) {
//     user.update((val) {
//       val?.galleryImages = images;
//     });
//     updateCompletionPercentage();
//   }
//
//   void setActiveSubscription(int index) {
//     activeSubscriptionIndex.value = index;
//   }
//
//   List<SubscriptionFeature> getFeaturesForTier(String tier) {
//     return subscriptionFeatures[tier.toLowerCase()] ?? [];
//   }
//
//   void handleUpgrade(String tier) {
//     user.update((val) {
//       val?.upgradeSubscription(tier);
//     });
//     log('Upgraded to $tier subscription');
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       user.update((user) {
//         user?.profileImage = image.path;
//       });
//       updateCompletionPercentage();
//     }
//   }
//
//   void updateCompletionPercentage()
//   {
//     int filledFields = 0;
//     int totalFields = 21;
//
//     if (fullName.value.isNotEmpty) filledFields++;
//     if (email.value.isNotEmpty) filledFields++;
//     if (age.value.isNotEmpty) filledFields++;
//     if (education.value.isNotEmpty) filledFields++;
//     if (drink.value.isNotEmpty) filledFields++;
//     if (languages.isNotEmpty) filledFields++;
//     if (jobTitle.value.isNotEmpty) filledFields++;
//     if (city.value.isNotEmpty) filledFields++;
//     if (interests.isNotEmpty) filledFields++;
//     if (personalities.isNotEmpty) filledFields++;
//     if (description.value.isNotEmpty) filledFields++;
//     if (intentions.value.isNotEmpty) filledFields++;
//     if (bornPlace.value.isNotEmpty) filledFields++;
//     if (gender.value.isNotEmpty) filledFields++;
//     if (date.value.isNotEmpty) filledFields++;
//     if (selectedCountry.value.isNotEmpty) filledFields++;
//     if (religion.value.isNotEmpty) filledFields++;
//     if (community.value.isNotEmpty) filledFields++;
//     if (height.value.isNotEmpty) filledFields++;
//     if (starSign.value.isNotEmpty) filledFields++;
//     if (workout.value.isNotEmpty) filledFields++;
//
//     completionPercentage.value = (filledFields / totalFields) * 100;
//
//     // Save to local storage
//     final
//     box = GetStorage();
//     box.write("completionPercentage", completionPercentage.value);
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     final box = GetStorage();
//     completionPercentage.value = box.read("completionPercentage") ?? 0.0;
//     fetchUserData().then((_) {
//       updateCompletionPercentage();
//     });
//     try {
//       final
//       imageController = Get.find<ImageController>();
//       if (imageController.imageList.isNotEmpty) {
//         updateGalleryImages(imageController.imageList);
//       }
//     } catch (e) {
//       log("ImageController not found");
//     }
//   }
//
//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   fetchUserData();
//   //   try {
//   //     final imageController = Get.find<ImageController>();
//   //     if (imageController.imageList.isNotEmpty) {
//   //       updateGalleryImages(imageController.imageList);
//   //     }
//   //   } catch (e) {
//   //     log('ImageController not found');
//   //   }
//   // }
//
//   var fullName = ''.obs;
//   var email = ''.obs;
//   var age = ''.obs;
//   var education = ''.obs;
//   var drink = ''.obs;
//   var languages = <String>[].obs;
//   var jobTitle = ''.obs;
//   var city = ''.obs;
//   var interests = <String>[].obs;
//   var personalities = <String>[].obs;
//   var description = ''.obs;
//   var intentions = ''.obs;
//   var bornPlace = ''.obs;
//   var gender = ''.obs;
//   var date = ''.obs;
//   var selectedCountry = ''.obs;
//   var religion = ''.obs;
//   var community = ''.obs;
//   var height = ''.obs;
//   var starSign = ''.obs;
//   var workout = ''.obs;
//   var isLoading = true.obs;
//
//   Future<void> fetchUserData() async {
//     try {
//       String? userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId != null) {
//         DocumentSnapshot userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();
//
//         if (userDoc.exists) {
//           var data = userDoc.data() as Map<String, dynamic>? ?? {};
//
//           fullName.value = data['fullName'] ?? 'Unknown';
//           email.value = data['email'] ?? 'No Email';
//           selectedCountry.value = data['selectedCountry'] ?? '';
//           religion.value = data['selectedReligion'] ?? '';
//           languages.value = List<String>.from(data['selectedLanguages'] ?? []);
//           community.value = data['selectedCommunity'] ?? '';
//           education.value = data['selectedEducation'] ?? '';
//           date.value = data['dateOfBirth'] ?? '';
//           gender.value = data.containsKey('selectedGender') ? data['selectedGender'] ?? '' : '';
//           height.value = data['selectedHeight'] ?? '';
//           jobTitle.value = data['jobTitle'] ?? '';
//           intentions.value = data['selectedIntention'] ?? '';
//           drink.value = data['selectedDrink'] ?? '';
//           workout.value = data['selectedWorkout'] ?? '';
//           starSign.value = data['selectedStarSign'] ?? '';
//           personalities.value = data.containsKey('selectedPersonalities')
//           ? List<String>.from(data['selectedPersonalities'] ?? [])
//           : [];
//           description.value = data['description'] ?? '';
//           interests.value = data.containsKey('selectedInterests')
//           ? List<String>.from(data['selectedInterests'] ?? [])
//           : [];
//           age.value = data['age'] ?? '';
//           city.value = data['currentCity'] ?? '';
//           bornPlace.value = data['bornPlace'] ?? '';
//         }
//
//
//         // if (userDoc.exists) {
//         //   fullName.value = userDoc['fullName'] ?? 'Unknown';
//         //   email.value = userDoc['email'] ?? 'No Email';
//         //   education.value = userDoc['selectedEducation'] ?? '';
//         //   drink.value = userDoc['selectedDrink'] ?? '';
//         //   languages.value = List<String>.from(userDoc['selectedLanguages'] ?? []);
//         //   interests.value = List<String>.from(userDoc['selectedInterests'] ?? []);
//         //   personalities.value = List<String>.from(userDoc['selectedPersonalities'] ?? []);
//         //   jobTitle.value = userDoc['jobTitle'] ?? '';
//         //   description.value = userDoc['description'] ?? '';
//         //   intentions.value = userDoc['selectedIntention'] ?? '';
//         //   gender.value = userDoc['selectedGender'] ?? '';
//         //   date.value = userDoc['dateOfBirth'] ?? '';
//         //   selectedCountry.value = userDoc['selectedCountry'] ?? '';
//         //   religion.value = userDoc['selectedReligion'] ?? '';
//         //   community.value = userDoc['selectedCommunity'] ?? '';
//         //   height.value = userDoc['selectedHeight'] ?? '';
//         //   starSign.value = userDoc['selectedStarSign'] ?? '';
//         //   workout.value = userDoc['selectedWorkout'] ?? '';
//         //   age.value =userDoc['age'] ?? '';
//         //   city.value = userDoc['currentCity'] ?? '';
//         //   bornPlace.value = userDoc['bornPlace'] ?? '';
//         // }
//       }
//     } catch (e) {
//       log("Error fetching user data: $e");
//     } finally {
//       isLoading.value = false;
//       updateCompletionPercentage();
//     }
//   }
//
//   void updateFullNameLocally(String newAge) {
//     age.value = newAge;
//   }
//
// // Method to update any field
//   Future<void> updateField(String field, String newValue) async {
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId != null) {
//         dynamic valueToStore = newValue; // Default is string
//
//         // Convert to list if field requires a list
//         List<String> listFields = ['selectedLanguages', 'selectedInterests', 'selectedPersonalities'];
//
//         // Convert to list if field is in the listFields
//         if (listFields.contains(field)) {
//           valueToStore = newValue.split(',').map((e) => e.trim()).toList();
//         }
//
//         await FirebaseFirestore.instance.collection('users').doc(userId).set({
//           field: valueToStore,
//         }, SetOptions(merge: true));
//
//         // Update local field variable
//         if (field == 'age') {
//           age.value = newValue;
//         }
//         else if (field == 'selectedEducation') {
//           education.value = newValue;
//         }
//         else if (field == 'selectedDrink') {
//           drink.value = newValue;
//         }
//         else if (field == 'jobTitle') {
//           jobTitle.value = newValue;
//         }
//         else if (field == 'currentCity') {
//           city.value = newValue;
//         }
//         else if (field == 'selectedLanguages') {
//           languages.assignAll(valueToStore);
//         }
//         else if (field == 'selectedInterests') {
//           interests.assignAll(valueToStore);
//         }
//         else if (field == 'selectedPersonalities') {
//           personalities.assignAll(valueToStore);
//         }
//         else if (field == 'description') {
//           description.value = newValue;
//         }
//         else if (field == 'selectedIntention') {
//           intentions.value = newValue;
//         }
//         else if (field == 'bornPlace') {
//           bornPlace.value = newValue;
//         }
//         else if (field == 'selectedGender') {
//           gender.value = newValue;
//         }
//         else if (field == 'dateOfBirth') {
//           date.value = newValue;
//         }
//         else if (field == 'selectedCountry') {
//           selectedCountry.value = newValue;
//         }
//         else if (field == 'selectedReligion') {
//           religion.value = newValue;
//         }
//         else if (field == 'selectedCommunity') {
//           community.value = newValue;
//         }
//         else if (field == 'selectedHeight') {
//           height.value = newValue;
//         }
//         else if (field == 'selectedStarSign') {
//           starSign.value = newValue;
//         }
//         else if (field == 'selectedWorkout') {
//           workout.value = newValue;
//         }
//
//         Get.snackbar('Success', '$field updated successfully');
//         updateCompletionPercentage();
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update $field: $e');
//     }
//   }
// }
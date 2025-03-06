import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/image_controller.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/custom_image_grid.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../res/components/custom_success_dialog.dart';
import 'package:nikkah_app/view/BottomNavBar/main_home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_signup_button.dart';

class ImagePickerScreen extends StatelessWidget {
  final bool fromEditProfile;
  const ImagePickerScreen({super.key, this.fromEditProfile = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    print('image picker screen');

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 3.0,top: 10.h,bottom: 20.h),
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                  size: 22,
                ),
              ),
            ),

            Text('Add your Photos', style: TextStyles.appBarText),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 160.h,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Obx(() => ImageGridItem(
                  index: index,
                  imageUrl: index < controller.imageList.length ? controller.imageList[index] : null,
                )),
              ),
            ),

            Center(
              child: CustomSignUpButton(
                text: 'Done',
                onPressed: () {
                  if (fromEditProfile) {
                    Get.back();  // Agar EditProfile se aaye ho toh sirf back karo
                    try {
                      final userProfileController = Get.find<EditProfileController>();
                      userProfileController.updateGalleryImages(controller.imageList);
                    } catch (e) {
                      print('UserProfileController not found');
                    }
                  } else {
                  if (controller.hasImages) {
                    try {
                      final userProfileController = Get.find<EditProfileController>();
                      userProfileController.updateGalleryImages(controller.imageList);
                    } catch (e) {
                      print('UserProfileController not found');
                    }
                    Get.dialog(
                      CustomWelcomeDialog(
                        title: "Great!",
                        message: "Your photos have been uploaded successfully!",
                        onClose: () {
                          Get.back();
                          Get.to(() => MainHomeScreen());
                        },
                      ),
                      barrierDismissible: false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please select at least one image.',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ));

                  }
                  }
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}














// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../res/colors/app_colors.dart';
// import '../res/styles/app_text_style.dart';
// import '../view_model/image_controller.dart';
// import '../res/components/custom_stepper.dart';
// import '../res/components/custom_image_grid.dart';
// import '../view_model/edit_profile_controller.dart';
// import '../res/components/custom_success_dialog.dart';
// import 'package:nikkah_app/view/main_home_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nikkah_app/res/components/custom_signup_button.dart';
//
// class ImagePickerScreen extends StatelessWidget {
//   const ImagePickerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ImageController());
//
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomStepper(currentStep: 17, totalSteps: 17),
//             SizedBox(height: 20.h),
//             Text(
//               'Add your Photos',
//               style: TextStyles.appBarText,
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 10.h,
//                   mainAxisExtent: 160.h,
//                   crossAxisSpacing: 10.w,
//                 ),
//                 itemCount: 6,
//                 itemBuilder: (context, index) => ImageGridItem(index: index),
//               ),
//             ),
//             Center(
//               child: CustomSignUpButton(
//                 text: 'Done',
//                 onPressed: () {
//                   if (controller.hasImages) {
//                     try {
//                       final userProfileController = Get.find<EditProfileController>();
//                       userProfileController.updateGalleryImages(controller.imageList);
//                     } catch (e) {
//                       log('UserProfileController not found');
//                     }
//                     Get.dialog(
//                       CustomWelcomeDialog(
//                         title: "Great!",
//                         message: "Your photos have been uploaded successfully!",
//                         onClose: () {
//                           Get.back();
//                           Get.to(() => MainHomeScreen());
//                         },
//                       ),
//                       barrierDismissible: false,
//                     );
//                   } else {
//                     Get.snackbar(
//                       'Error',
//                       'Please select at least one image.',
//                       snackPosition: SnackPosition.BOTTOM,
//                       margin: EdgeInsets.all(16.w),
//                     );
//                   }
//                 },
//               ),
//             ),
//             SizedBox(height: 10.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../res/colors/app_colors.dart';
// // import '../res/components/custom_image_grid.dart';
// // import '../res/components/custom_signup_button.dart';
// // import '../res/components/custom_stepper.dart';
// // import '../res/components/custom_success_dialog.dart';
// // import '../res/styles/app_text_style.dart';
// // import '../view_model/image_controller.dart';
// // import '../view_model/edit_profile_controller.dart';
// // import 'main_home_screen.dart';
// //
// //
// // class ImagePickerScreen extends StatelessWidget {
// //   const ImagePickerScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(ImageController());
// //     // Make sure UserProfileController is instantiated here
// //     final userProfileController = Get.put(UserProfileController());  // Ensure the controller is initialized
// //
// //     return Scaffold(
// //       backgroundColor: AppColors.whiteColor,
// //       body: Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const CustomStepper(currentStep: 17, totalSteps: 17),
// //             SizedBox(height: 20.h),
// //             Text('Add your Photos', style: TextStyles.appBarText),
// //             Expanded(
// //               child: GridView.builder(
// //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 3,
// //                   crossAxisSpacing: 10.w,
// //                   mainAxisSpacing: 10.h,
// //                   mainAxisExtent: 160.h,
// //                 ),
// //                 itemCount: 6,
// //                 itemBuilder: (context, index) => ImageGridItem(index: index),
// //               ),
// //             ),
// //             Center(
// //               child: CustomSignUpButton(
// //                 text: 'Done',
// //                 onPressed: () async {
// //                   if (controller.hasImages) {
// //                     try {
// //                       // final userProfileController = Get.find<UserProfileController>();
// //                       final userId = FirebaseAuth.instance.currentUser?.uid;
// //
// //                       // Upload images to Supabase and save URLs
// //                       await uploadImagesAndSaveUrls(controller.imageList, userId!);
// //
// //                       // Retrieve uploaded images and update UI
// //                       final uploadedImages = await getImagesForAuthenticatedUser();
// //                       userProfileController.updateGalleryImages(uploadedImages);
// //
// //                       // Show success dialog
// //                       Get.dialog(
// //                         CustomWelcomeDialog(
// //                           title: "Great!",
// //                           message: "Your account has been created successfully!",
// //                           onClose: () {
// //                             Get.back();
// //                             Get.to(() => MainHomeScreen());
// //                           },
// //                         ),
// //                         barrierDismissible: false,
// //                       );
// //                     } catch (e) {
// //                       log('Error: $e');
// //                     }
// //                   } else {
// //                     Get.snackbar(
// //                       'Error',
// //                       'Please select at least one image.',
// //                       snackPosition: SnackPosition.BOTTOM,
// //                       margin: EdgeInsets.all(16.w),
// //                     );
// //                   }
// //                 },
// //               ),
// //             ),
// //
// //             SizedBox(height: 10.h),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Function to upload an image to Supabase Storage
// //   Future<String?> uploadImageToSupabase(String filePath) async {
// //     try {
// //       final file = File(filePath);
// //       final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
// //
// //       // Upload image to Supabase Storage (Bucket: 'Nikkah')
// //       final response = await Supabase.instance.client.storage
// //           .from('Nikkah') // Use your bucket name here
// //           .upload(fileName, file);
// //
// //       // Check if response is empty (Upload failed)
// //       if (response.isEmpty) {
// //         throw Exception("Failed to upload image.");
// //       }
// //
// //       // Get the public URL of the uploaded image
// //       final imageUrl = Supabase.instance.client.storage
// //           .from('Nikkah') // Use your bucket name here
// //           .getPublicUrl(fileName);
// //
// //       return imageUrl;
// //     } catch (e) {
// //       log('Error uploading image: $e');
// //       return null;
// //     }
// //   }
// //
// //
// //   // Function to save image URLs to Supabase Database
// //   Future<void> saveImageUrlsToDatabase(List<String> imageUrls, String userId) async {
// //     try {
// //       if (imageUrls.isNotEmpty) {
// //         await Supabase.instance.client
// //             .from('user_images') // Make sure this table exists in Supabase
// //             .upsert([
// //           {
// //             'user_id': userId,      // Store user ID (Same as Firebase user ID)
// //             'image_urls': imageUrls, // Store uploaded image URLs
// //           }
// //         ]);
// //       }
// //
// //       log('Images saved successfully in Supabase Database.');
// //     } catch (e) {
// //       log('Error saving images to database: $e');
// //     }
// //   }
// //   Future<List<String>> getImagesForAuthenticatedUser() async {
// //     try {
// //       // Get the current user from Firebase
// //       final user = FirebaseAuth.instance.currentUser;
// //
// //       if (user == null) {
// //         log('No user is logged in');
// //         return [];
// //       }
// //
// //       final userId = user.uid; // Get Firebase user ID
// //       final response = await Supabase.instance.client
// //           .from('user_images')
// //           .select('image_urls')
// //           .eq('user_id', userId)
// //           .single();
// //
// //       if (response == null) {
// //         return [];
// //       }
// //
// //       return List<String>.from(response['image_urls'] ?? []);
// //     } catch (e) {
// //       log('Error fetching images: $e');
// //       return [];
// //     }
// //   }
// //
// //   Future<void> uploadImagesAndSaveUrls(List<String> imagePaths, String userId) async {
// //     try {
// //       List<String> imageUrls = [];
// //
// //       for (String path in imagePaths) {
// //         final imageUrl = await uploadImageToSupabase(path);
// //         if (imageUrl != null) {
// //           imageUrls.add(imageUrl);
// //         }
// //       }
// //
// //       // Save image URLs to Supabase Database
// //       await saveImageUrlsToDatabase(imageUrls, userId);
// //     } catch (e) {
// //       log('Error uploading and saving images: $e');
// //     }
// //   }
// //
// // }
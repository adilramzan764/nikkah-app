import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import 'package:nikkah_app/view/SignUp/image_selection_screen.dart';
import '../../res/colors/app_colors.dart';
import '../../model/user_profile_model.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../res/components/custom_profile_button.dart';
import '../../res/components/custom_user_profile_grid.dart';
import '../../res/components/custom_profile_edit_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/components/subscription_comparison_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nikkah_app/res/components/custom_build_profile_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController editProfileController =
        Get.put(EditProfileController());
    final TextEditingController textController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Edit Profile',
          style: TextStyles.appBarText,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Done',
              style: TextStyles.appBarText.copyWith(
                fontSize: 14.sp,
                color: AppColors.blueColor,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        var user = editProfileController.user.value;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileButtons(
                isPreviewActive: false,
                onEditPressed: () {},
                onPreviewPressed: () => Get.back(),
                // onPreviewPressed: () {
                //   Get.to(() => const UserProfilePreviewScreen(),
                //     transition: Transition.noTransition,
                //     duration: const Duration(milliseconds: 500),
                //   );
                // },
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180.w,
                    height: 200.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        end: Alignment.bottomRight,
                        begin: Alignment.bottomLeft,
                        colors: [AppColors.secondaryColor, Colors.grey],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.r),
                      child: Container(
                        width: 180.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5.w,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _getProfileImage(user),
                          child: _getProfileImageChild(user),
                        ),
                        // child: CircleAvatar(
                        //   radius: 30.r,
                        //   backgroundColor: Colors.grey[300],
                        //   backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                        //   ? FileImage(File(user.profileImage!)) as ImageProvider
                        //   : null,
                        //   child: user.profileImage == null || user.profileImage!.isEmpty
                        //   ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                        //   : null,
                        // ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 130.w,
                    child: GestureDetector(
                      onTap: () => Get.to(
                          () => ImagePickerScreen(fromEditProfile: true)),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: const Color(0xffCDCDCD),
                        child: Icon(
                          Icons.edit,
                          size: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      // width: 120.w,
                      height: 25.h,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      constraints: BoxConstraints(
                        minWidth: 120.w,
                        maxWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              '${editProfileController.completionPercentage.value.toStringAsFixed(1)}% Completed',
                              style: TextStyles.editProfileScreenCompletion,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  '${editProfileController.fullName.value}'
                  '${editProfileController.age.isNotEmpty ? ', ${editProfileController.age}' : ''}',
                  style: TextStyles.editProfileScreenUserName,
                ),
              ),
              SizedBox(height: 30.h),
              SubscriptionComparisonCard(controller: editProfileController),
              SizedBox(
                height: 15.h,
              ),
              if (user.galleryImages.isNotEmpty) ...[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child:
                  UserProfileGalleryGrid(
                    images: user.galleryImages,
                    onDelete: (String imageUrl) {
                      editProfileController.deleteImageFromFirebase(imageUrl).then((_) {
                        user.galleryImages.remove(imageUrl);
                        Get.forceAppUpdate(); // Refresh UI
                      }).catchError((e) {
                        print(' Error deleting image: $e');
                      }).whenComplete(() {
                        // Stop loading after deletion
                        // loadingUrl.value = '';
                      });
                    },
                  )


                ),
                SizedBox(height: 10.h),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      'Describe Yourself',
                      style: TextStyles.editProfileScreenListTitleHeading,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => Get.toNamed(RoutesName.descriptionScreen,
                        arguments: {'isSignUp': false}),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: AppColors.greyColor.withOpacity(0.1),
                          border: Border.all(
                            color: AppColors.greyColor.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    editProfileController
                                            .description.value.isNotEmpty
                                        ? editProfileController
                                            .description.value
                                        : 'Add description',
                                    style: editProfileController
                                            .description.isNotEmpty
                                        ? TextStyles.editProfileScreenListTitle
                                        : TextStyles
                                            .editProfileScreenListTrailing,
                                  ),
                                ),
                              ),
                              Icon(
                                size: 18,
                                Icons.arrow_forward_ios_outlined,
                                color: AppColors.greyColor.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Obx(() {
                        // Live word count update
                        int wordCount = editProfileController.description.value
                            .trim()
                            .split(RegExp(r'\s+'))
                            .where((word) => word.isNotEmpty)
                            .length;
                        return Text(
                          '$wordCount/300',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              // Intentions Section
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  'Intentions',
                  style: TextStyles.editProfileScreenListTitleHeading,
                ),
              ),
              CustomBuildProfileField(
                title: 'Looking for',
                value: editProfileController.intentions.value.isNotEmpty
                    ? editProfileController.intentions.value
                    : "Add",
                icon: Icons.arrow_forward_ios_outlined,
                onTap: () => Get.toNamed(RoutesName.intentionScreen,
                    arguments: {'isSignUp': false}),

                //   EditDialogHelper.showEditDialog(
                // context, textController,
                // 'Intentions', 'Enter your Intentions', (updatedValue) {
                //   editProfileController.updateField('selectedIntention',updatedValue);
                // },
                // ),
              ),
              // Basic Section
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 15.h),
                child: Text(
                  'Basic',
                  style: TextStyles.editProfileScreenListTitleHeading,
                ),
              ),
              CustomBuildProfileField(
                title: 'Age',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.age.value.isNotEmpty
                    ? editProfileController.age.value
                    : "Add",
                onTap: () => EditDialogHelper.showEditDialog(
                  context,
                  textController,
                  'Age',
                  'Enter Age',
                  (updatedValue) {
                    editProfileController.updateField('age', updatedValue);
                  },
                ),
              ),
              CustomBuildProfileField(
                title: 'Born',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.bornPlace.value.isNotEmpty
                    ? editProfileController.bornPlace.value
                    : "Add",
                onTap: () => EditDialogHelper.showEditDialog(
                  context,
                  textController,
                  'Born',
                  'Enter city name',
                  (updatedValue) {
                    editProfileController.updateField(
                        'bornPlace', updatedValue);
                  },
                ),
              ),
              CustomBuildProfileField(
                title: 'Gender',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.gender.value.isNotEmpty
                    ? editProfileController.gender.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.genderScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Birthday',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.date.value.isNotEmpty
                    ? editProfileController.date.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.dateOfBirth,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Education Level',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.education.value.isNotEmpty
                    ? editProfileController.education.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.educationScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Job Title',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.jobTitle.value.isNotEmpty
                    ? editProfileController.jobTitle.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.jobTileScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Country',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.selectedCountry.value.isNotEmpty
                    ? editProfileController.selectedCountry.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.countryScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Religion',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.religion.value.isNotEmpty
                    ? editProfileController.religion.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.religionScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Community',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.community.value.isNotEmpty
                    ? editProfileController.community.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.communityScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Languages',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.languages.isNotEmpty
                    ? editProfileController.languages.join(', ')
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.languageScreen,
                    arguments: {'isSignUp': false}),
              ),
              // Lifestyle Section
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 15.h),
                child: Text(
                  'Lifestyle',
                  style: TextStyles.editProfileScreenListTitleHeading,
                ),
              ),
              CustomBuildProfileField(
                title: 'Height',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.height.value.isNotEmpty
                    ? editProfileController.height.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.heightScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Drink',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.drink.value.isNotEmpty
                    ? editProfileController.drink.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.drinkScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Interest',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.interests.isNotEmpty
                    ? editProfileController.interests.join(', ')
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.interestScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Star Sign',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.starSign.value.isNotEmpty
                    ? editProfileController.starSign.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.starSign,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Work Out',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.workout.value.isNotEmpty
                    ? editProfileController.workout.value
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.workoutScreen,
                    arguments: {'isSignUp': false}),
              ),
              CustomBuildProfileField(
                title: 'Personality',
                icon: Icons.arrow_forward_ios_outlined,
                value: editProfileController.personalities.isNotEmpty
                    ? editProfileController.personalities.join(', ')
                    : "Add",
                onTap: () => Get.toNamed(RoutesName.personalityScreen,
                    arguments: {'isSignUp': false}),
              ),
              // Living In Section
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 15.h),
                child: Text(
                  'Living In',
                  style: TextStyles.editProfileScreenListTitleHeading,
                ),
              ),
              CustomBuildProfileField(
                icon: Icons.arrow_forward_ios_outlined,
                title: editProfileController.city.value.isNotEmpty
                    ? editProfileController.city.value
                    : "Add City",
                onTap: () => EditDialogHelper.showEditDialog(
                  context,
                  textController,
                  'City',
                  'Enter your city',
                  (updatedValue) {
                    editProfileController.updateField(
                        'currentCity', updatedValue);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ImageProvider? _getProfileImage(UserProfileModel user) {
    if (user.profileImage != null && user.profileImage!.isNotEmpty) {
      // If there's a profile image set, use it
      return FileImage(File(user.profileImage!));
    } else if (user.galleryImages.isNotEmpty) {
      // If there's no profile image but there are gallery images, use the first gallery image
      return CachedNetworkImageProvider(user.galleryImages.first);
    }
    // If there's no profile image and no gallery images, return null (will show the icon)
    return null;
  }

  Widget? _getProfileImageChild(UserProfileModel user) {
    if ((user.profileImage == null || user.profileImage!.isEmpty) &&
        user.galleryImages.isEmpty) {
      // Only show the icon if there's no profile image and no gallery images
      return Icon(Icons.person, size: 60.sp, color: Colors.grey);
    }
    return null;
  }
}

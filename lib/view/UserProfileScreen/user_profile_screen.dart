import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/home_controller.dart';
import '../../res/components/custom_stepper.dart';
import 'package:nikkah_app/res/colors/colors.dart';
import '../../view_model/edit_profile_controller.dart';
import 'package:nikkah_app/view/settings_screen.dart';
import '../../res/components/custom_profile_button.dart';
import 'package:nikkah_app/view/EditProfileScreen/edit_profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nikkah_app/res/components/custom_loading_dialog.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController editProfileController = Get.put(EditProfileController());
    CompanionViewModel viewModel = Get.put(CompanionViewModel());

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (viewModel.pageHistory.isNotEmpty) {
            viewModel.goBack();
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: AppColors.whiteColor,
          title: Text('Profile', style: TextStyles.appBarText,),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => viewModel.goBack(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () => Get.to(() => const SettingScreen()),
            ),
          ],
        ),
        body: Obx(() {
          if (editProfileController.isLoading.value) {
            return const Center(
              child: LoadingDialog(),
            );
          }
          var user = editProfileController.user.value;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Edit/Preview Toggle
                ProfileButtons(
                  isPreviewActive: true,
                  // onEditPressed: () => Get.back(),
                  onEditPressed: () => Get.to(() => const EditProfileScreen(),
                    transition: Transition.noTransition,
                    duration: const Duration(milliseconds: 500),
                  ),
                  onPreviewPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Profile Image with CustomStepper
                      SizedBox(
                        width: 312.w,
                        height: 650.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              if (user.galleryImages.isNotEmpty)
                                Obx(() => CachedNetworkImage(
                                  imageUrl: user.galleryImages[
                                    editProfileController.currentStep.value
                                  ],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (context, url) => Center(
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Colors.purple, Colors.blue],
                                        ).createShader(bounds);
                                      },
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 6.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                )),
                              // Gradient overlay
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                  ),
                                ),
                              ),
                              // Name, Age, and Job Title over the image
                              Positioned(
                                left: 20.w,
                                bottom: 20.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${editProfileController.fullName}'
                                      '${editProfileController.age.isNotEmpty
                                      ? ', ${editProfileController.age}' : ''}',
                                      style: TextStyles.userProfileScreenUserNameAndAge,
                                    ),
                                    Text(
                                      editProfileController.jobTitle.value.isNotEmpty
                                      ? editProfileController.jobTitle.value : "",
                                      style: TextStyles.userProfileScreenUserJobTitle,
                                    ),
                                    SizedBox(height: 6.h),
                                    SizedBox(
                                      width: 334.w,
                                      child: Theme(
                                        data: ThemeData(useMaterial3: false,),
                                        child: Wrap(
                                          spacing: 6,
                                          runSpacing: -6,
                                          children: editProfileController.
                                          interests.map<Widget>((interest) {
                                            return CustomChip(
                                              label: interest,
                                              backgroundColor: AppColors.intentionsColor,
                                              textStyle: TextStyles.userProfileScreenUserIntentions,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // CustomStepper
                              Positioned(
                                top: 20.h,
                                left: 10.w,
                                right: 10.w,
                                child: Obx(() => CustomStepper(
                                  activeColor: AppColors.whiteColor,
                                  totalSteps: user.galleryImages.length,
                                  inactiveColor: AppColorsTwo.stepperOne,
                                  currentStep: editProfileController.currentStep.value,
                                )),
                              ),
                              // Navigation arrows
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 10.h,
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    size: 130.sp,
                                    Icons.chevron_left,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: editProfileController.previousStep,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 10.h,
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    size: 130.sp,
                                    Icons.chevron_right,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: editProfileController.nextStep,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Profile Info
                      Container(
                        width: 396.w,
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          color: AppColors.userProfileScreenCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${editProfileController.fullName}'
                                  '${editProfileController.age.isNotEmpty
                                  ? ', ${editProfileController.age}' : ''}',
                                  style: TextStyles.userProfileScreenUserNameAndAge.
                                  copyWith(color: AppColors.blackColor),
                                ),
                                Container(
                                  width: 154.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryColor,
                                        AppColors.secondaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Intentions',
                                        style: TextStyles.userProfileScreenUserIntentions.
                                        copyWith(color: AppColors.blackColor),
                                      ),
                                      Text(
                                        editProfileController.intentions.value.isNotEmpty
                                        ? editProfileController.intentions.value :'N/A',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Height: ${editProfileController.height}',
                                  style: TextStyles.userProfileScreenUserIntentions.
                                  copyWith(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.school_outlined,
                                  color: AppColors.secondaryColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Education: ${editProfileController.education}',
                                  style: TextStyles.userProfileScreenUserIntentions.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.dislikeButtonColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Location: ${editProfileController.selectedCountry}',
                                  style: TextStyles.userProfileScreenUserIntentions.
                                  copyWith(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // About Me Section
                      Container(
                        width: 396.w,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: AppColors.userProfileScreenCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About me', style: TextStyles.userProfileScreenAboutMe,),
                            SizedBox(height: 12.h),
                            Text(
                              editProfileController.description.value.isNotEmpty
                              ? editProfileController.description.value : 'N/A',
                              style: TextStyles.userProfileScreenAboutMeContent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Basic Section (directly integrated)
                      Container(
                        width: 396.w,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: AppColors.userProfileScreenCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Basic', style: TextStyles.userProfileScreenAboutMe,),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label: 'Walking',),
                                ),
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label:'Good Food',),
                                ),
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label: 'Night Life',),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Container(
                        width: 400.w,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: AppColors.userProfileScreenCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My Interest', style: TextStyles.userProfileScreenAboutMe,),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: 354.w,
                              child: Wrap(
                                spacing: 8,
                                runSpacing: -8,
                                children: editProfileController.
                                interests.map<Widget>((interest) {
                                  return Theme(
                                    data: ThemeData(useMaterial3: false,),
                                    child: CustomChip(label: interest,),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Container(
                        width: 396.w,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: AppColors.userProfileScreenCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Interest', style: TextStyles.userProfileScreenAboutMe,),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label: 'Walking',),
                                ),
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label:'Good Food',),
                                ),
                                Theme(
                                  data: ThemeData(useMaterial3: false,),
                                  child: const CustomChip(label: 'Night Life',),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
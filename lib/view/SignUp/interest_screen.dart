import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/interest_chip.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/interest_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestsScreen extends StatelessWidget {
  bool isSignUp;
  InterestsScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(InterestsController());
    final InterestsController controller = Get.find<InterestsController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.interests.value = editProfileController.interests.value ?? [];
    controller.categories.forEach((category) {
      category.interests.forEach((interest) {
        if (controller.interests.contains(interest.name)) {
          interest.isSelected = true;
        }
      });
    });
    controller.selectedCount.value = controller.categories.expand((c) => c.interests).where((i) => i.isSelected).length;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSignUp) ...[

                // Custom Stepper
                const CustomStepper(currentStep: 13, totalSteps: 17),
                SizedBox(height: 24.h),
              ]
              else
                Padding(
                  padding:  EdgeInsets.only(left: 3.0,top: 10.h,bottom: 20.h),
                  child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.blackColor,
                          size: 22,
                        ),
                      ),
                      Text(
                        '${controller.selectedCount.value}/10 Selected',
                        style: TextStyles.listTile.copyWith(
                          color: controller.selectedCount.value >= 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),),

              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your Interests',
                      style: TextStyles.topHeading,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Select your interest to match with users who have similar'
                      ' interests like you. Pick any 10',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: category.interests.map((interest) => InterestChip(
                            interest: interest,
                            onTap: () => controller.toggleInterest(interest),
                          ),).toList(),
                        ),
                      ],
                    );
                  },
                ),),
              ),
              if(isSignUp)
              Obx(() => Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Get.toNamed(RoutesName.jobTileScreen,arguments: {'isSignUp': true}),
                      child: Text(
                        'Skip',
                        style: TextStyles.skipButton,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.selectedCount.value >= 1 ? () {
                        Get.toNamed(RoutesName.jobTileScreen);
                      } : null,
                      child: Text(
                        '${controller.selectedCount.value}/10 Selected',
                        style: TextStyles.listTile.copyWith(
                          color: controller.selectedCount.value >= 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ))
              else...[
                  Center(
                    child: CustomSignUpButton(
                        text: 'Update',
                        onPressed: () {
                          controller.updateInterestsInFirebase(editProfileController);
                        }

                    ),
                  ),
                  SizedBox(height: 20.h,)

                ]
            ],
          ),
        ),
      ),
        floatingActionButton: isSignUp ? Obx(() => ForwardFloatingButton(
          onPressed: controller.selectedCount.value > 0 && controller.selectedCount.value <= 10
              ? () {
            String? userId = FirebaseAuth.instance.currentUser?.uid;
            if (userId != null) {
              controller.uploadInterests(userId);
              Get.toNamed(RoutesName.jobTileScreen,arguments: {'isSignUp': true});
            }
          }
              : () {
            Customsnackbar_SignUpScreens.showSnackbar(
              message:controller.selectedCount.value <0 ? 'Please select at least one interest' : 'You can only select up to 10 interests',
              context: context,
            );
          },
          icon: Icons.arrow_forward_ios,
        )) : SizedBox()
    );

  }
}
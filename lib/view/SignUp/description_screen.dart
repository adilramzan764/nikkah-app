import 'package:get/get.dart';
import 'package:nikkah_app/Widgets/CustomLoader.dart';
import 'package:nikkah_app/res/components/custom_login_button.dart';
import 'package:nikkah_app/res/components/custom_signup_button.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/custom_skip_button.dart';
import '../../view_model/description_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/edit_profile_controller.dart';

class DescriptionScreen extends StatelessWidget {
  bool isSignUp;

   DescriptionScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(DescriptionController());
    final DescriptionController controller = Get.find<DescriptionController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();

    controller.textController.text = editProfileController.description.value ?? '';

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: isSignUp==false ? AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
            size: 20,
          ),
          onPressed: () {
              Get.back();

          },
        ),
      ) : null,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16 ,vertical: isSignUp ? 16 :0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSignUp) ...[
                // Custom Stepper
                const CustomStepper(currentStep: 12, totalSteps: 17),
                SizedBox(height: 24.h),
              ],

              // Top Row with icon and title
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Icon(
                    size: IconSize.topIcon,
                    Icons.description_outlined,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Describe yourself',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // TextField for description
              Container(
                height: 200.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: controller.textController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add more about you...',
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  onChanged: (value) {
                    controller.setDescription(value);
                  },
                ),
              ),
              // Spacer to push content up
              const Spacer(),
              // Bottom Row for Skip and Forward Buttons
              if (isSignUp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  const SkipButton(routeName: RoutesName.interestScreen),
                  ForwardFloatingButton(
                    onPressed: () async {
                      if (controller.canProceed()) {
                        await controller.uploadDescriptionToFirebase();
                        controller.navigateToInterestsScreen();
                      } else {
                        Customsnackbar_SignUpScreens.showSnackbar(
                          message: 'Please add a description',
                          context: context,
                        );
                      }
                    },
                    icon: Icons.arrow_forward_ios,
                  ),
                ],
              )
              else
                Center(
                  child: CustomSignUpButton(
                    text: 'Update',
                    onPressed: () {
                     controller.updateDescriptionToFirebase(editProfileController);
                      }

                  ),
                ),

              SizedBox(height: 20.h,)

            ],
          ),
        ),
      ),
    );
  }
}
import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/custom_skip_button.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/personality_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalityScreen extends StatelessWidget {
  bool isSignUp;
  PersonalityScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(PersonalityController());
    final PersonalityController controller = Get.find<PersonalityController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedPersonalities.value = editProfileController.personalities.value ?? [];

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
                const CustomStepper(currentStep: 11, totalSteps: 17),
                SizedBox(height: 24.h),
              ]
              else
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
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Icon(
                    size: 24.w,
                    Icons.person,
                    color: AppColors.blackColor,
                  ), // Adjusted for consistent sizing
                  SizedBox(width: 20.w),
                  Text('Personality', style: TextStyles.topHeading),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: personalityTraits.length,
                  itemBuilder: (context, index) {
                    final personality = personalityTraits[index];
                    return Obx(() {
                      return GestureDetector(
                        onTap: () => controller.togglePersonality(personality),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w,
                          ),
                          leading: Transform.scale(
                            scale: 1.2.w,
                            child: GradientCheckbox(
                              value: controller.selectedPersonalities.contains(personality),
                              onChanged: (bool? value) {
                                controller.togglePersonality(personality);
                              },
                            ),
                          ),
                          title: Row(
                            children: [
                              SizedBox(width: 16.w),
                              Text(personality, style: TextStyles.listTile,),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              if (isSignUp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  const SkipButton(
                    routeName: RoutesName.descriptionScreen,
                  ),
                  ForwardFloatingButton(
                    onPressed: () async {
                      if (controller.canProceed()) {
                        await controller.uploadPersonalitiesToFirebase();
                        controller.navigateToDescriptionScreen();
                      } else {
                        Customsnackbar_SignUpScreens.showSnackbar(
                          message: 'Please select at least one personality trait',
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
                      controller.updatePersonalitiesToFirebase(editProfileController);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
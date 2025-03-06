import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/education_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/gradient_checkbox.dart';

class EducationScreen extends StatelessWidget {
  bool isSignUp;
    EducationScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(EducationController());
    final EducationController controller = Get.find<EducationController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedEducation.value = editProfileController.education.value ?? '';

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
                const CustomStepper(currentStep: 4, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Icon(
                    Icons.school_outlined,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Education',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: educationLevelsList.length,
                  itemBuilder: (context, index) {
                    final education = educationLevelsList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedEducation.value == education,
                          onChanged: (bool? value) => controller.
                          setEducation(value == true ? education : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            education,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setEducation(
                        controller.selectedEducation.value == education ? '' : education,
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateEducationToFirebase(editProfileController);
                      }

                  ),
                ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
      floatingActionButton: isSignUp ? ForwardFloatingButton(
        onPressed: () async {
          if (controller.canProceed()) {
            await controller.uploadEducationToFirebase();
            controller.navigateToDateOfBirthScreen();
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select a education',
              context: context,
            );
            // Get.snackbar('Error', 'Please select a education');
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
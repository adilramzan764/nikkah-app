import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/gender_controller.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/gradient_checkbox.dart';

class GenderScreen extends StatelessWidget {
  bool isSignUp;
   GenderScreen({ required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(GenderController());
    final GenderController controller = Get.find<GenderController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedGender.value = editProfileController.gender.value ?? '';

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
                const CustomStepper(currentStep: 6, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Icon(
                    Icons.person,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Gender',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: genderOptions.length,
                  itemBuilder: (context, index) {
                    final gender = genderOptions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedGender.value == gender,
                          onChanged: (bool? value) => controller.
                          setGender(value == true ? gender : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            gender,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setGender(
                        controller.selectedGender.value == gender ? '' : gender,
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
                        controller.updateGenderToFirebase(editProfileController);
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
            await controller.uploadGenderToFirebase();
            controller.navigateToHeightScreen();
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(message: 'Please select your gender', context: context);
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : null,
    );
  }
}
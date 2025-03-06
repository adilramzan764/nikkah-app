import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/height_controller.dart';
import '../../res/components/custom_stepper.dart';
import 'package:nikkah_app/res/list/lists.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightScreen extends StatelessWidget {
  bool isSignUp;
    HeightScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(HeightController());
    final controller = Get.find<HeightController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedHeight.value = editProfileController.height.value ?? '';

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
                const CustomStepper(currentStep: 7, totalSteps: 17),
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
                    Icons.straighten,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Height',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: heights.length,
                  itemBuilder: (context, index) {
                    final height = heights[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedHeight.value == height.measurement,
                          onChanged: (bool? value) => controller.
                          setHeight(value == true ? height.measurement : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            height.display,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setHeight(
                        controller.selectedHeight.value == height.measurement
                        ? '' : height.measurement,
                      ),
                    );
                  },
                ),
              ),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateHeightToFirebase(editProfileController);
                      }

                  ),
                ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
      floatingActionButton:isSignUp ? ForwardFloatingButton(
        onPressed: () async {
          if (controller.canProceed()) {
            await controller.uploadHeightToFirebase();
            controller.navigateToDrinkScreen();
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select your height',
              context: context,
            );
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
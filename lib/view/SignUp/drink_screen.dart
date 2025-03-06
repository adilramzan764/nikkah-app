import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/drink_controller.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/custom_skip_button.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/edit_profile_controller.dart';

class DrinkScreen extends StatelessWidget {
  bool isSignUp;
  DrinkScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(DrinkController());
    final DrinkController controller = Get.find<DrinkController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedDrink.value = editProfileController.drink.value ?? '';


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
                const CustomStepper(currentStep: 8, totalSteps: 17),
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
                    Icons.wine_bar,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Drink',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: drinkOptions.length,
                  itemBuilder: (context, index) {
                    final drink = drinkOptions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedDrink.value == drink,
                          onChanged: (bool? value) => controller.
                          setDrink(value == true ? drink : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            drink,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setDrink(
                        controller.selectedDrink.value == drink ? '' : drink,
                      ),
                    );
                  },
                ),
              ),
              if(isSignUp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SkipButton(
                    routeName: RoutesName.workoutScreen,
                  ),
                  ForwardFloatingButton(
                    onPressed: () async {
                      if (controller.canProceed()) {
                        await controller.uploadDrinkToFirebase();
                        controller.navigateToWorkoutScreen();
                      } else {
                        Customsnackbar_SignUpScreens.showSnackbar(
                          message: 'Please select your drink preference',
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
                          controller.updateDrinkToFirebase(editProfileController);
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
import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/work_out_controller.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/custom_skip_button.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutScreen extends StatelessWidget {
  bool isSignUp;
    WorkoutScreen({required this.isSignUp});

  final WorkoutController controller = Get.put(WorkoutController());
  final EditProfileController editProfileController = Get.find<EditProfileController>();


  @override
  Widget build(BuildContext context) {
    controller.selectedWorkout.value = editProfileController.workout.value ?? '';
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
                const CustomStepper(currentStep: 9, totalSteps: 17),
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
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                    Icons.settings_accessibility,
                  ),
                  SizedBox(width: 20.w),
                  Text('Workout', style: TextStyles.topHeading,),
                ],
              ),
              SizedBox(height: 16.h),
              // List of workout options
              Expanded(
                child: ListView.builder(
                  itemCount: workoutOptions.length,
                  itemBuilder: (context, index) {
                    final workout = workoutOptions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedWorkout.value == workout,
                          onChanged: (bool? value) => controller.
                          setWorkout(value == true ? workout : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(workout, style: TextStyles.listTile,),
                        ],
                      ),
                      onTap: () => controller.setWorkout(
                        controller.selectedWorkout.value == workout ? '' : workout,
                      ),
                    );
                  },
                ),
              ),
              if(isSignUp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SkipButton(routeName: RoutesName.starSign,),
                  ForwardFloatingButton(
                    onPressed: () async {
                      if (controller.canProceed()) {
                        await controller.uploadWorkoutToFirebase();
                        controller.navigateToStarSignScreen();
                      } else {
                        Customsnackbar_SignUpScreens.showSnackbar(
                          message: 'Please select a workout option',
                          context: context
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
                        controller.updateWorkoutToFirebase(editProfileController);
                      }

                  ),
                ),            ],
          ),
        ),
      ),
    );
  }
}
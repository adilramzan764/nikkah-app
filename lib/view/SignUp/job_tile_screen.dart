import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_signup_button.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/job_title_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobTitleScreen extends StatelessWidget {
  bool isSignUp;
  JobTitleScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(JobTitleController());
    final JobTitleController controller = Get.find<JobTitleController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.textController.text = editProfileController.jobTitle.value ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
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
                const CustomStepper(currentStep: 14, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Text(
                'Job Title',
                style: TextStyles.topHeading,
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: controller.textController,
                onChanged: (value) {
                  controller.setJobTitle(value);
                },
                decoration: InputDecoration(
                  hintText: 'Ex: Software Engineer',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h,),
                ),
              ),
              Spacer(),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateJobTitleToFirebase(editProfileController);
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
            await controller.uploadJobTitleToFirebase();
            controller.navigateToIntensionScreen();
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please enter your job title',
              context: context,
            );
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
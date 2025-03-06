import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import 'package:nikkah_app/res/list/lists.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/intentions_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntentionsScreen extends StatelessWidget {
  bool isSignUp;
   IntentionsScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(IntentionController());
    final IntentionController controller = Get.find<IntentionController>() ;
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedIntention.value = editProfileController.intentions.value ?? '';

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
                const CustomStepper(currentStep: 15, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Text(
                'Intentions',
                style: TextStyles.topHeading,
              ),
              SizedBox(height: 24.h),
              Text(
                'Looking for / Relationship Goal options should be:',
                style: GoogleFonts.prociono(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.builder(
                  itemCount: intentions.length,
                  itemBuilder: (context, index) {
                    final intention = intentions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedIntention.value == intention,
                          onChanged: (bool? value) => controller.
                          setIntention(value == true ? intention : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            intention,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setIntention(
                        controller.selectedIntention.value == intention ? '' : intention,
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
                      controller.updateIntensionsToFirebase(editProfileController);
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
            await controller.uploadIntentionToFirebase();
            controller.navigateToImagePickerScreen();
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select an intention',
              context: context,
            );
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox()
    );
  }
}
import 'package:get/get.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/community_controller.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/gradient_checkbox.dart';

import '../../view_model/edit_profile_controller.dart';

class CommunityScreen extends StatelessWidget {
  bool isSignUp;
    CommunityScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    final CommunityController controller = Get.put(CommunityController());
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedCommunity.value = editProfileController.community.value ?? '';

    return Scaffold(
      backgroundColor:AppColors.whiteColor,

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16 ,vertical: isSignUp ? 16 :0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSignUp) ...[
                // Custom Stepper
                const CustomStepper(currentStep: 3, totalSteps: 17),
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
                    Icons.group_work_outlined,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Community',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: communitiesList.length,
                  itemBuilder: (context, index) {
                    final community = communitiesList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedCommunity.value == community,
                          onChanged: (bool? value) => controller.
                          setCommunity(value == true ? community : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            community,
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setCommunity(
                        controller.selectedCommunity.value == community ? '' : community,
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
                        controller.updateCommunityToFirebase(editProfileController);
                      }

                  ),
                ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
      floatingActionButton: isSignUp ?  ForwardFloatingButton(
        onPressed: () async {
          if (controller.canProceed()) {
            await controller.uploadCommunityToFirebase();
            controller.navigateToEducation();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please select a community',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );

          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
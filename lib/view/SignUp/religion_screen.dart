import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../routes/routes_name.dart';
import '../../view_model/edit_profile_controller.dart';
import '../../view_model/religion_controller.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReligionScreen extends StatelessWidget {
  bool isSignUp;
  ReligionScreen({required this.isSignUp});

  final ReligionController controller = Get.put(ReligionController());



  @override
  Widget build(BuildContext context) {
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedReligion.value = editProfileController.religion.value ?? '';

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16 ,vertical: isSignUp ? 16 :0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSignUp) ...[
                // Custom Stepper
                const CustomStepper(currentStep: 1, totalSteps: 17),
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
                    Icons.mosque,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text('Religion', style: TextStyles.topHeading,),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: religionsList.length,
                  itemBuilder: (context, index) {
                    final religion = religionsList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: Obx(() => GradientCheckbox(
                          // Wrap Checkbox with Obx
                          value: controller.selectedReligion.value == religion,
                          onChanged: (bool? value) => controller.
                          setReligion(value == true ? religion : ''),
                        )),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(religion, style: TextStyles.listTile,),
                        ],
                      ),
                      onTap: () => controller.setReligion(
                        controller.selectedReligion.value == religion ? '' : religion,
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
                        controller.updateReligionToFirebase(editProfileController);
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
            await controller.uploadReligionToFirebase();
            controller.navigateToLanguage();

          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select a religion',
              context: context
            );

            // Get.snackbar('Error', 'Please select a religion');
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
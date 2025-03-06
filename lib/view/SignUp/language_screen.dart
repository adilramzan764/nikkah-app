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
import '../../view_model/language_controller.dart';
import '../../res/components/gradient_checkbox.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageScreen extends StatelessWidget {
  bool isSignUp;
    LanguageScreen({required this.isSignUp});

  final LanguageController controller = Get.put(LanguageController());
  final EditProfileController editProfileController = Get.find<EditProfileController>();



  @override
  Widget build(BuildContext context) {
    controller.selectedLanguages.value = editProfileController.languages.value ?? [];
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
                const CustomStepper(currentStep: 2, totalSteps: 17),
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
                    Icons.language,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Languages',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: languagesList.length,
                  itemBuilder: (context, index) {
                    final language = languagesList[index];
                    return Obx(() {
                      return GestureDetector(
                        onTap: () => controller.toggleLanguage(language),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w,
                          ),
                          leading: Transform.scale(
                            scale: 1.2.w,
                            child: GradientCheckbox(
                              value: controller.selectedLanguages.contains(language),
                              onChanged: (bool? value) {
                                controller.toggleLanguage(language);
                              },
                            ),
                          ),
                          title: Row(
                            children: [
                              SizedBox(width: 16.w),
                              Text(language, style: TextStyles.listTile,),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateLanguageToFirebase(editProfileController);
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
            await controller.uploadLanguagesToFirebase();
            controller.navigateToCommunity();

          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select at least one language',
              context: context,
            );

            // Get.snackbar('Error', 'Please select at least one language');
          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}

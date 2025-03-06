import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_stepper.dart';
import '../../view_model/country_controller.dart';
import '../../res/components/gradient_checkbox.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/edit_profile_controller.dart';

class CountryScreen extends StatelessWidget {
  bool isSignUp;
    CountryScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(CountryController());
    final CountryController controller = Get.find<CountryController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.selectedCountry.value = editProfileController.selectedCountry.value ?? '';

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
                const CustomStepper(currentStep: 0, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Icon(
                    Icons.flag,
                    size: IconSize.topIcon,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Select Country',
                    style: TextStyles.topHeading,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return Obx(() => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      leading: Transform.scale(
                        scale: 1.2.w,
                        child: GradientCheckbox(
                          value: controller.selectedCountry.value == country['name'],
                          onChanged: (bool? value) => controller.
                          setCountry(value == true ? country['name'] : ''),
                        ),
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Text(
                            country['flag'],
                            style: TextStyles.listTile,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            country['name'],
                            style: TextStyles.listTile,
                          ),
                        ],
                      ),
                      onTap: () => controller.setCountry(controller.selectedCountry.
                      value == country['name'] ? '' : country['name']),
                    ));
                  },
                ),
              ),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateCountryToFirebase(editProfileController);
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
            await controller.uploadCountryToFirebase();
            Get.toNamed(RoutesName.religionScreen,arguments: {'isSignUp': true});
          } else {
            Customsnackbar_SignUpScreens.showSnackbar(
              message: 'Please select a country',
              context: context,
            );


          }
        },
        icon: Icons.arrow_forward_ios,
      ) : SizedBox(),
    );
  }
}
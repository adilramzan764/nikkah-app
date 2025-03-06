import 'package:get/get.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_signup_button.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/dob_controller.dart';
import '../../res/components/custom_stepper.dart';
import '../../res/components/forward_floating_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/edit_profile_controller.dart';

class DateOfBirthScreen extends StatelessWidget {
  bool isSignUp;
  DateOfBirthScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    Get.put(DateOfBirthController());
    final DateOfBirthController controller = Get.find<DateOfBirthController>();
    final EditProfileController editProfileController = Get.find<EditProfileController>();
    controller.dateOfBirth.value = editProfileController.date.value != null && editProfileController.date.value!.isNotEmpty
        ? DateTime.tryParse(editProfileController.date.value!)
        : null;

    final currentYear = DateTime.now().year;

    // Function to show date picker
    void _showDatePicker() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Start with current date
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.whiteColor,
                onSurface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.dayController.value.text = picked.day.toString().padLeft(2, '0');
        controller.monthController.value.text = picked.month.toString().padLeft(2, '0');
        controller.yearController.value.text = picked.year.toString();
        controller.setDateOfBirth(picked);
      }
    }

    // // Show date picker automatically when screen loads
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (controller.dateOfBirth.value == null) {
    //     _showDatePicker();
    //   }
    // });

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
            children: [
              if (isSignUp) ...[
                // Custom Stepper
                const CustomStepper(currentStep: 5, totalSteps: 17),
                SizedBox(height: 24.h),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.cake_outlined, size: 24.sp, color: AppColors.blackColor),
                  SizedBox(width: 10.w),
                  Text('Birthday', style: TextStyles.topHeading),
                ],
              ),
              SizedBox(height: 25.h),
              Column(
                children: [
                  // Labels
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Day', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp)),
                                Obx(() => TextField(
                                  controller: controller.dayController.value,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                    hintText: 'DD',
                                    hintStyle: TextStyle(color: Colors.grey), // Keep hint in grey
                                  ),
                                  style: TextStyle(
                                    color: controller.dateOfBirth.value != null ? Colors.black : Colors.grey, // Change text color dynamically
                                  ),
                                  readOnly: true, // Make field read-only
                                  enabled: false, // Disable field
                                )),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Month', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp)),
                                Obx(() => TextField(
                                  controller: controller.monthController.value,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                    hintText: 'MM',
                                    hintStyle: TextStyle(color: Colors.grey), // Hint remains grey
                                  ),
                                  style: TextStyle(
                                    color: controller.dateOfBirth.value != null ? Colors.black : Colors.grey, // Change text color dynamically
                                  ),
                                  readOnly: true,
                                  enabled: false,
                                )),                                    ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Year', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp)),
                                // Year Field
                                Obx(() => TextField(
                                  controller: controller.yearController.value,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                    hintText: 'YYYY',
                                    hintStyle: TextStyle(color: Colors.grey), // Hint remains grey
                                  ),
                                  style: TextStyle(
                                    color: controller.dateOfBirth.value != null ? Colors.black : Colors.grey, // Change text color dynamically
                                  ),
                                  readOnly: true,
                                  enabled: false,
                                )),                                ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),
                      // Calendar Button - Make this more prominent
                      InkWell(
                        onTap: _showDatePicker,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF6448FE),
                                Color(0xFF5FC6FF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 18.sp, color: Colors.white),
                              SizedBox(width: 8.w),
                              Text(
                                'Select from Calendar',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              Spacer(),
              if (!isSignUp)
                Center(
                  child: CustomSignUpButton(
                      text: 'Update',
                      onPressed: () {
                        controller.updateDOBToFirebase(editProfileController);
                        // controller.updateDescriptionToFirebase(editProfileController);
                      }

                  ),
                ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
      floatingActionButton: isSignUp ?  Obx(() =>  ForwardFloatingButton(
        onPressed: controller.dateOfBirth.value != null ? () {
          controller.uploadDateOfBirthToFirebase(); // Upload to Firebase
          controller.navigateToGenderScreen(); // Navigate to next screen
        } : (){
          Customsnackbar_SignUpScreens.showSnackbar(
            message: 'Please select your date of birth',
            context: context,
          );
        },
        icon: Icons.arrow_forward_ios,
      )  ): SizedBox(),
    );
  }
}
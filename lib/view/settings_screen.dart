import 'package:get/get.dart';
import '../res/list/lists.dart';
import 'package:flutter/material.dart';
import '../res/colors/app_colors.dart';
import '../res/styles/app_text_style.dart';
import '../res/components/custom_slider.dart';
import '../view_model/settings_controller.dart';
import '../view_model/edit_profile_controller.dart';
import '../res/components/custom_switch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/components/subscription_comparison_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());
    final SettingsController settingController = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text('Preference', style: TextStyles.appBarText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dating Profile',
                    style: TextStyles.phoneNumberAndEmail,
                  ),
                  Obx(() => CustomGradientSwitch(
                    value: settingController.isSwitched.value,
                    onChanged: () {
                      settingController.toggleSwitch();
                    },
                  )),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'When turned off, your profile will not be visible to others, '
                    'but you still are able to chat with your matches and access ',
                style: TextStyles.settingScreenProfileText,
              ),
              SizedBox(height: 24.h),
              // Subscription Plan Placeholder
              SubscriptionComparisonCard(controller: controller),
              SizedBox(height: 24.h),
              Container(
                width: 396.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColors.greyColor.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Phone Number',
                        style: TextStyles.phoneNumberAndEmail,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          // Get.to(const PhoneVerificationScreen());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '+91 222-345690',
                              style: TextStyles.phoneNumberAndEmailValue,
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: IconSize.rightForwardIcon.size,
                              color: IconSize.rightForwardIcon.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      indent: 20.w,
                      thickness: 0.5,
                      endIndent: 20.w,
                      color: AppColors.greyColor,
                    ),
                    ListTile(
                      title: Text('Email', style: TextStyles.phoneNumberAndEmail),
                      trailing: InkWell(
                        onTap: () {
                          // Get.to(const EmailVerificationScreen());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'abc667@gmail.com',
                              style: TextStyles.phoneNumberAndEmailValue,
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: IconSize.rightForwardIcon.size,
                              color: IconSize.rightForwardIcon.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Distance Preference
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance Preference',
                        style: TextStyles.phoneNumberAndEmail,
                      ),
                      Text(
                        '50 km',
                        style: TextStyles.phoneNumberAndEmail.
                        copyWith(color: AppColors.greyColor,),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  GradientSlider(
                    min: 0,
                    max: 100,
                    value: 50,
                    onChanged: (value) {
                      // Handle value change
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Interested in',
                style: TextStyles.phoneNumberAndEmail,
              ),
              SizedBox(height: 16.h),
              Obx(() => Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: ['Male', 'Female', 'Everyone'].
                map((interest) => GestureDetector(
                  onTap: () => settingController.toggleInterest(interest),
                  child: Container(
                    width: 80.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      gradient: settingController.isInterestSelected(interest)
                      ? const LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                      ) : null,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: settingController.isInterestSelected(interest)
                        ? Colors.transparent
                        : AppColors.greyColor.withOpacity(0.5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        interest,
                        style: settingController.isInterestSelected(interest)
                        ? TextStyles.selectedInterest
                        : TextStyles.interestSelect,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )).toList(),
              )),
              SizedBox(height: 24.h),
              Text(
                'Religious Preference',
                style: TextStyles.phoneNumberAndEmail,
              ),
              SizedBox(height: 16.h),
              Obx(() => Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: religionsList.map((religion) => GestureDetector(
                  onTap: () => settingController.toggleReligion(religion),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: settingController.isReligionSelected(religion)
                      ? const LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                      ) : null,
                      border: Border.all(
                        color: settingController.isReligionSelected(religion)
                        ? Colors.transparent
                        : AppColors.greyColor.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      religion,
                      style: settingController.isReligionSelected(religion)
                      ? TextStyles.selectedInterest
                      : TextStyles.interestSelect,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )).toList(),
              )),
              SizedBox(height: 16.h),
              // Bottom Links
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'Terms of Service',
                      style: TextStyles.phoneNumberAndEmail,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: IconSize.rightForwardIcon.size,
                      color: IconSize.rightForwardIcon.color,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Privacy Policy',
                      style: TextStyles.phoneNumberAndEmail,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: IconSize.rightForwardIcon.size,
                      color: IconSize.rightForwardIcon.color,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Delete Account',
                      style: TextStyles.phoneNumberAndEmail,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: IconSize.rightForwardIcon.size,
                      color: IconSize.rightForwardIcon.color,
                    ),
                    onTap: () => settingController.showDeleteDialog(),
                  ),
                  ListTile(
                    title: Text(
                      'Sign Out',
                      style: TextStyles.phoneNumberAndEmail,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: IconSize.rightForwardIcon.size,
                      color: IconSize.rightForwardIcon.color,
                    ),
                    onTap: () => settingController.showLogoutDialog(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
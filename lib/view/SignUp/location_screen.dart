import 'package:get/get.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_signup_button.dart';

class LocationScreen extends StatelessWidget {
  bool isSignUp;
  LocationScreen({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70,),
            Row(
              children: [
                Icon(
                  size: 24.sp,
                  Icons.share_location,
                  color: AppColors.blackColor,
                ),
                SizedBox(width: 20.w),
                Text('Location', style: TextStyles.topHeading,),
              ],
            ),
            SizedBox(height: 30.h),
            Text('Set your Location Services', style: TextStyles.topHeading),
            SizedBox(height: 20.h),
            Text(
              'We use your location to show you potential \n matches in your area',
              style: TextStyles.listTile.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            const Spacer(),
            Center(
              child: CustomSignUpButton(
                text: 'Set Location Services',
                onPressed: () => Get.toNamed(RoutesName.countryScreen,arguments: {'isSignUp': true}),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
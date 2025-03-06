import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import 'package:nikkah_app/res/images/images_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_login_button.dart';
import 'package:nikkah_app/res/components/custom_signup_button.dart';
import 'package:nikkah_app/res/components/custom_repeated_text.dart';

class LogInAScreen extends StatelessWidget {
  const LogInAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            width: 730.w,
            height: 567.h,
            fit: BoxFit.cover,
            MyImageClass.logInA,
          ),
          const Spacer(),
          const RepeatedText(text: 'Find Your Perfect \nCompanion',),
          const Spacer(),
          CustomSignUpButton(
            text: 'Sign Up',
            onPressed: () => Get.toNamed(RoutesName.signUpScreen),
          ),
          SizedBox(height: 5.h),
          CustomLoginButton(
            text: 'Log In',
            onPressed: () => Get.toNamed(RoutesName.loginCScreen),
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
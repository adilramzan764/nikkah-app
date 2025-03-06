import 'package:get/get.dart';
import '../../routes/routes_name.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/custom_text_field.dart';
import '../../res/components/custom_signup_button.dart';
import 'package:nikkah_app/res/images/images_assets.dart';
import 'package:nikkah_app/res/styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailCodeScreen extends StatelessWidget {
  const EmailCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 55.h,),

              Center(
                child: Image.asset(
                  width: 228.w,
                  height: 252.h,
                  MyImageClass.logInC,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Find Your Perfect \nCompanion',
                textAlign: TextAlign.center,
                style: TextStyles.headingOne,
              ),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyles.forget,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Verification was just sent to abc....@gmail.com',
                    style: TextStyles.textButton,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Enter code',
                    style: TextStyles.textField,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  SizedBox(height: 32.h),
                  CustomSignUpButton(
                    text: 'Next',
                    onPressed: () => Get.toNamed(RoutesName.newPasswordScreen),
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
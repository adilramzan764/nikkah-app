import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/images/images_assets.dart';
import '../../res/styles/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_repeated_text.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w,),
            child: Column(
              children: [
                SizedBox(height: 35.h,),

                Center(
                  child: Image.asset(
                    width: 228.w,
                    height: 252.h,
                    MyImageClass.logInC,
                  ),
                ),
                SizedBox(height: 10.h),
                const RepeatedText(text: 'Find Your Perfect \nCompanion'),
                SizedBox(height: 24.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Account Login', style: TextStyles.forget),
                    SizedBox(height: 16.h),
                    Text(' New Password', style: TextStyles.textField),
                    const SizedBox(height: 8,),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty
                      ? 'Please enter your Password' : null,
                    ),
                    SizedBox(height: 16.h),
                    Text(' Confirm New Password', style: TextStyles.textField),
                    const SizedBox(height: 8,),
                    CustomTextField(
                      obscureText: true,
                      validator: (value) => value!.isEmpty
                      ? 'Please enter your new password' : null,
                    ),
                    SizedBox(height: 32.h),
                    CustomSignUpButton(
                      text: 'Done',
                      onPressed: () => Get.toNamed(RoutesName.loginCScreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
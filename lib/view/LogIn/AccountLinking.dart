import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Widgets/CustomSnackBar.dart';
import '../../res/components/custom_login_button.dart';
import '../../res/images/images_assets.dart';
import '../../res/styles/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_repeated_text.dart';
import 'package:nikkah_app/res/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_text_field.dart';

import '../../view_model/SigninContoller.dart';

class LinkGoogleAccountScreen extends StatelessWidget {
  final String email;
   LinkGoogleAccountScreen({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w),
            child: Column(
              children: [
                SizedBox(height: 35.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Link Google Account', style: TextStyles.forget),
                    SizedBox(height: 16.h),
                    Text(
                      'Enter your password to link your Google account with your email $email. This helps us secure your account and provide seamless access.',
                      style: TextStyles.textField.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.greyColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(' Password', style: TextStyles.textField),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.accountLinkPassword,
                      obscureText: true,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your password' : null,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Get.toNamed(RoutesName.forgetPasswordScreen),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.textField.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height *0.08),
                    Obx(() => CustomSignUpButton(
                      text: controller.isLoading.value ? 'Linking...' : 'Link Account',
                      onPressed: () {
                        controller.linkGoogleAccount(email, controller.accountLinkPassword.value.text);
                      },
                    )),


                    SizedBox(height: 20.h),
                    CustomLoginButton(
                      text: 'Cancel',
                      onPressed: () => Get.back(),
                    ),                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
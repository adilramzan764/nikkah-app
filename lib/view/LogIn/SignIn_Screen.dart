import 'package:get/get.dart';
import '../../routes/routes_name.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/images/images_assets.dart';
import '../../res/styles/app_text_style.dart';
import '../../res/components/custom_text_field.dart';
import '../../res/components/custom_signup_button.dart';
import '../../res/components/custom_repeated_text.dart';
import '../../view_model/SignIN_Controller.dart';
import '../../view_model/authentication_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../BottomNavBar/main_home_screen.dart';

class LogInCScreen extends StatelessWidget {
  const LogInCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 35.h,
            horizontal: 38.w,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    width: 228.w,
                    height: 252.h,
                    MyImageClass.logInC,
                  ),
                ),
                SizedBox(height: 24.h),
                const Center(
                  child: RepeatedText(text: 'Find Your Perfect \nCompanion',),
                ),
                SizedBox(height: 24.h),
                Text(' Account Login', style: TextStyles.forget,),
                SizedBox(height: 16.h),
                Text(' Email Address', style: TextStyles.textField,),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.email,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('  Password', style: TextStyles.textField,),
                ),
                CustomTextField(
                  obscureText: true,
                  controller: controller.password,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Obx(() =>
                        //     Checkbox(
                        //       value: loginViewModel.rememberMe.value,
                        //       onChanged: (value) =>
                        //           loginViewModel.toggleRememberMe(),
                        //     )),
                        Text("Remember me", style: TextStyles.rememberMe,),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(RoutesName.forgetPasswordScreen),
                      child: Text("Forget Password?", style: TextStyles.rememberMe,),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomSignUpButton(
                  text: 'Log in',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.loginUser(
                        controller.email.text.trim(),
                        controller.password.text.trim(),
                      );
                    }
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 10.w,
                        thickness: 0.5.h,
                        color: Colors.black,
                      ),
                    ),
                    Text("Or log in with", style: TextStyles.textButton,),
                    Expanded(
                      child: Divider(
                        indent: 10.w,
                        thickness: 0.5.h,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          controller.signInWithFacebook();
                          // Get.snackbar('Success', 'Signed in with Google successfully');
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.facebookImage,
                      ),
                    ),
                    SizedBox(width: 35.w),
                    GestureDetector(
                      onTap: () => controller.signInWithGoogle(),
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.googleImage,
                        // Optional: Apply a color filter if needed
                      ),
                    ),
                    SizedBox(width: 35.w),
                    GestureDetector(
                      onTap: () => Get.toNamed(RoutesName.phoneNumberAuthScreen),
                      child: SvgPicture.asset(
                        width: 40.w,
                        height: 40.h,
                        MyImageClass.whatsappImage,
                        // Optional: Apply a color filter if needed
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: 'By continuing you agree to our ',
                      style: TextStyles.textButton,
                      children: [
                        TextSpan(
                          text: 'Terms',
                          style: TextStyles.textButton.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: ' & ', style: TextStyles.textButton,),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyles.textButton.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
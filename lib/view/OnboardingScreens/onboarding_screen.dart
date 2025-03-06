import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../model/onboarding_model.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/onboarding_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController _controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: (index) {
                _controller.currentPage.value = index;
              },
              itemCount: _controller.onboardingPages.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  model: _controller.onboardingPages[index],
                );
              },
            ),
            // Skip Button
            Positioned(
              top: 20.h,
              right: 20.w,
              child: TextButton(
                onPressed: _controller.skipToLastPage,
                child: Text(
                  'Skip',
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 18.sp,),
                ),
              ),
            ),
            // Bottom Controls
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 40.h,
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _controller.onboardingPages.length,
                      (index) => Obx(() => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: _controller.currentPage.value == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: _controller.currentPage.value == index
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Next/Get Started Button
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: _controller.nextPage,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.secondaryColor,
                            ],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(31.r),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Obx(() => Text(
                            _controller.currentPage.value ==
                                _controller.onboardingPages.length - 1
                            ? 'Get Started' : 'Next',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white,),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            model.imageUrl,
            height: 0.4.sh,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40.h),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyles.onBoardingTitleText,
          ),
          SizedBox(height: 16.h),
          Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyles.onBoardingDescriptionText,
          ),
        ],
      ),
    );
  }
}
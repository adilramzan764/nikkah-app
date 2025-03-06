import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../res/colors/app_colors.dart';
import '../res/styles/app_text_style.dart';
import '../view_model/free_tonight_controller.dart';
import '../res/components/custom_home_indicator.dart';
import '../res/components/custom_home_action_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FreeTonightScreen extends StatelessWidget {
  final FreeTonightController controller = Get.put(FreeTonightController());

   FreeTonightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentUser = controller.currentUser;
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              controller.previousUser();
            } else if (details.primaryVelocity! < 0) {
              controller.nextUser();
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.toNightColorOne,
                        AppColors.toNightColorTwo,
                      ],
                      end: Alignment.bottomRight,
                      begin: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              // "Free Tonight" Container with Close Button
              Positioned(
                top: 50.h,
                left: 24.w,
                right: 24.w,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 32.sp,
                        color: Colors.white,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                          end: Alignment.topRight,
                          begin: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: Text(
                          'Free Tonight',
                          style: TextStyles.freeToNightScreenProfession,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // User Image in a Rounded Container
              Positioned(
                top: 130.h,
                left: 20.w,
                right: 20.w,
                child: Container(
                  width: double.infinity,
                  height: 670.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12.r,
                        spreadRadius: 2.r,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(currentUser.image, fit: BoxFit.cover,),
                  ),
                ),
              ),
              // Step Indicator
              Positioned(
                top: 160.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.mensaUsers.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: StepIndicator(isActive: controller.currentIndex.value == index),
                    ),
                  ),
                ),
              ),
              // User Details with Nearby Tag
              Positioned(
                bottom: 100.h,
                left: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.nearbyColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'Nearby',
                        style: TextStyles.freeToNightScreenNearby,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '${currentUser.name}, ${currentUser.age}',
                      style: TextStyles.freeToNightScreenUserNameAndAge,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 18.sp),
                        SizedBox(width: 6.w),
                        Text(
                          '${currentUser.distance} km away',
                          style: TextStyles.freeToNightScreenLocation,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      currentUser.profession,
                      style: TextStyles.freeToNightScreenProfession,
                    ),
                  ],
                ),
              ),
              // Action Buttons
              Positioned(
                left: 24.w,
                right: 24.w,
                bottom: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      icon: Icons.bolt,
                      gradientColors: const [
                        AppColors.boostBtnColorOne,
                        AppColors.boostBtnColorTwo,
                      ],
                      onPressed: () {},
                    ),
                    ActionButton(
                      icon: Icons.close,
                      gradientColors: const [
                        AppColors.dislikeBtnColorOne,
                        AppColors.dislikeBtnColorTwo,
                      ],
                      onPressed: () {},
                    ),
                    ActionButton(
                      icon: Icons.star,
                      gradientColors: const [
                        AppColors.starBtnColorOne,
                        AppColors.starBtnColorTwo,
                      ],
                      onPressed: () {},
                    ),
                    ActionButton(
                      icon: Icons.favorite,
                      gradientColors: const [
                        AppColors.likeBtnColorOne,
                        AppColors.likeBtnColorTwo,
                      ],
                      onPressed: () {},
                    ),
                    ActionButton(
                      icon: Icons.description,
                      gradientColors: const [
                        AppColors.descriptionBtnColorOne,
                        AppColors.descriptionBtnColorTwo,
                      ],
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
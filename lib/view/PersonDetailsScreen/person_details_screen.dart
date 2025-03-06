import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/home_controller.dart';
import '../../res/components/custom_home_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/res/components/custom_home_action_button.dart';

class PersonDetailsScreen extends StatelessWidget {
  final CompanionViewModel viewModel = Get.find<CompanionViewModel>();

  PersonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        title: Text(
          'Details',
          style: TextStyles.appBarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: Column(
            children: [
              Obx(() {
                final user = viewModel.currentUser;
                if (user == null || user.imageUrls.isEmpty) {
                  return Center(
                    child: Text(
                      'No images available',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                }
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 390.w,
                          height: 340.h,
                          child: PageView.builder(
                            controller: PageController(
                              initialPage: viewModel.currentImageIndex,
                            ),
                            itemCount: user.imageUrls.length,
                            onPageChanged: (index) => viewModel.setImageIndex(index),
                            itemBuilder: (context, index) {
                              return Container(
                                // margin: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.asset(
                                    width: 390.w,
                                    height: 340.h,
                                    fit: BoxFit.fill,
                                    user.imageUrls[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              user.imageUrls.length, (index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: StepIndicator(
                                  isActive: viewModel.currentImageIndex == index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 15.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${user.name}, ${user.age}',
                                style: TextStyles.userProfileScreenUserNameAndAge.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              Container(
                                width: 154.w,
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.secondaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Intentions',
                                      style: TextStyles.userProfileScreenUserIntentions.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      'Intentions',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                size: 20.w,
                                Icons.straighten_outlined,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Height',
                                style: TextStyles.userProfileScreenUserIntentions.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                size: 20.w,
                                Icons.school_outlined,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Education',
                                style: TextStyles.userProfileScreenUserIntentions.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                size: 20.w,
                                Icons.location_on_outlined,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Location',
                                style: TextStyles.userProfileScreenUserIntentions.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Divider(
                            indent: 5.w,
                            endIndent: 5.w,
                            thickness: 0.5,
                            color: AppColors.greyColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            'About me',
                            style: TextStyles.userProfileScreenAboutMe,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Waiting for someone best partner',
                            style: TextStyles.personDetailInfo,
                          ),
                          SizedBox(height: 12.h,),
                          Divider(
                            indent: 5.w,
                            thickness: 0.5,
                            endIndent: 5.w,
                            color: AppColors.greyColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            'Basic',
                            style: TextStyles.userProfileScreenAboutMe,
                          ),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1),
                                ),
                                child: Text(
                                  'Walking',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1,),
                                ),
                                child: Text(
                                  'Good Food',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1),
                                ),
                                child: Text(
                                  'Night Life',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Divider(
                            indent: 5.w,
                            endIndent: 5.w,
                            thickness: 0.5,
                            color: AppColors.greyColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            'My Interest',
                            style: TextStyles.userProfileScreenAboutMe,
                          ),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1),
                                ),
                                child: Text(
                                  'Walking',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1),
                                ),
                                child: Text(
                                  'Good Food',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.black45, width: 1),
                                ),
                                child: Text(
                                  'Night Life',
                                  style: TextStyles.personDetailInfo,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              Padding(
                padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 40.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      icon: Icons.share,
                      gradientColors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                    ActionButton(
                      icon: Icons.not_interested_outlined,
                      gradientColors: [
                        AppColors.descriptionBtnColorOne,
                        AppColors.descriptionBtnColorTwo,
                      ],
                    ),
                    ActionButton(
                      icon: Icons.error_outline_outlined,
                      gradientColors: [
                        AppColors.boostBtnColorOne,
                        AppColors.boostBtnColorTwo,
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
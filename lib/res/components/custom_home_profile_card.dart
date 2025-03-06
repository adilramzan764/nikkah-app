import 'package:get/get.dart';
import '../colors/app_colors.dart';
import 'custom_home_indicator.dart';
import 'package:flutter/material.dart';
import 'custom_home_action_button.dart';
import '../../view_model/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/view/PersonDetailsScreen/person_details_screen.dart';

class ProfileCard extends StatelessWidget {
  final dynamic user;
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const ProfileCard({
    super.key,
    required this.user,
    required this.onLike,
    required this.isLiked,
    required this.onDislike,
    required this.isDisliked,
  });

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: Text('No user available'));
    }

    final CompanionViewModel viewModel = Get.find<CompanionViewModel>();

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          viewModel.previousImage();
        } else if (details.primaryVelocity! < 0) {
          viewModel.nextImage();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Obx(() {
                if (user.imageUrls.isEmpty) {
                  return Container(
                    color: Colors.grey,
                    child: const Center(child: Text('No image available')),
                  );
                }
                return Image.asset(
                  user.imageUrls[viewModel.currentImageIndex],
                  width: 398.w,
                  height: 736.h,
                  fit: BoxFit.fill,
                );
              }),
              _buildRefreshButton(viewModel),
              Obx(() => _buildStepIndicators(
                user.imageUrls.length,
                viewModel.currentImageIndex,
              )),
              _buildUserDetails(viewModel),
              _buildFeedbackLabel(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton(CompanionViewModel viewModel) {
    return Positioned(
      top: 50.h,
      left: 30.w,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: AppColors.blackColor, width: 2,),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Icon(Icons.refresh, size: 20.sp, color: AppColors.blackColor,),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicators(int total, int current) {
    return Positioned(
      top: 20.h,
      // left: 20.w,
      // right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          total, (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: StepIndicator(isActive: index == current),
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails(CompanionViewModel viewModel) {
    return Positioned(
      left: 30.w,
      right: 20.w,
      bottom: 110.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: viewModel.toggleActiveStatus,
            child: Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: viewModel.isActive ? AppColors.activeColor : AppColors.offlineColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    viewModel.isActive ? 'Active' : 'Recently Active',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )),
          ),
          SizedBox(height: 8.h),
          Text(
            '${user.name}, ${user.age}',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                size: 16.sp,
                color: Colors.white70,
                user.locationIcon ?? Icons.location_on,
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  '${user.location} • ${user.distanceKm?.toStringAsFixed(1) ?? "?"} km away',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            user.profession ?? 'No profession listed',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackLabel() {
    if (isLiked) {
      return _buildLabel('LIKE', Colors.green);
    }
    if (isDisliked) {
      return _buildLabel('DISLIKE', Colors.red.shade900);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLabel(String text, Color color) {
    return Positioned(
      top: 50.h,
      right: 30.w,
      child: Container(
        width: 90.w,
        height: 39.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: color, width: 2,),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10.h,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
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
              onPressed: onDislike,
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
                AppColors.likeBtnColorTwo
              ],
              onPressed: onLike,
            ),
            ActionButton(
              icon: Icons.description,
              gradientColors: const [
                AppColors.descriptionBtnColorOne,
                AppColors.descriptionBtnColorTwo,
              ],
              onPressed: () => Get.to(() => PersonDetailsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
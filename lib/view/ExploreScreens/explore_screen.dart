import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/styles/app_text_style.dart';
import '../../view_model/explore_controller.dart';
import '../../res/components/custom_explore_profile_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/components/custom_explore_screen_tab_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreScreen extends StatelessWidget {
  final ExploreViewModel exploreViewModel = Get.put(ExploreViewModel());
  final RxInt selectedTab = 0.obs;

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h,),
                child: Text(
                  "Explore",
                  style: TextStyles.exploreHeader,
                ),
              ),
              SizedBox(
                height: 50.h,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTabButton(
                            text: "Most Eligible",
                            isSelected: selectedTab.value == 0,
                            onTap: () => selectedTab.value = 0,
                          ),
                          SizedBox(width: 8.w),
                          CustomTabButton(
                            text: "Likes",
                            isSelected: selectedTab.value == 1,
                            onTap: () => selectedTab.value = 1,
                          ),
                          SizedBox(width: 8.w),
                          CustomTabButton(
                            text: "Super like",
                            isSelected: selectedTab.value == 2,
                            onTap: () => selectedTab.value = 2,
                          ),
                          SizedBox(width: 8.w),
                          CustomTabButton(
                            text: "Note",
                            isSelected: selectedTab.value == 3,
                            onTap: () => selectedTab.value = 3,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: Obx(() {
                if (exploreViewModel.users.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MasonryGridView.builder(
                  itemCount: exploreViewModel.users.length,
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  itemBuilder: (context, index) {
                    final heightFactor = index % 2 == 1 ? 0.5 : 0.7;
                    return ExploreProfileCard(
                      user: exploreViewModel.users[index],
                      height: ScreenUtil().screenWidth * heightFactor,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
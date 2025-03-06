import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'custom_subscription_card.dart';
import '../../view_model/edit_profile_controller.dart';

class SubscriptionComparisonCard extends StatelessWidget {
  final EditProfileController controller;

  const SubscriptionComparisonCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.88);
    pageController.addListener(() {
      double page = pageController.page ?? 0;
      int newIndex = page.round();
      if (newIndex != controller.activeSubscriptionIndex.value) {
        controller.activeSubscriptionIndex.value = newIndex;
      }
    });

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: [
              SubscriptionCard(
                title: 'Platinum',
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x50D95554), Color(0x00FFFFFF)],
                ),
                features: controller.getFeaturesForTier('platinum'),
                controller: controller,
                index: 0,
              ),
              SubscriptionCard(
                title: 'Gold',
                gradient: const LinearGradient(
                  colors: [Color(0x50FFB301), Color(0x00FFFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                features: controller.getFeaturesForTier('gold'),
                controller: controller,
                index: 1,
              ),
              SubscriptionCard(
                title: 'Silver',
                gradient: const LinearGradient(
                  colors: [Color(0x5031E3E5), Color(0x00FFFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                features: controller.getFeaturesForTier('silver'),
                controller: controller,
                index: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              height: 10,
              width: controller.activeSubscriptionIndex.value == index ? 25 : 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: controller.activeSubscriptionIndex.value == index
                ? _getIndicatorColor(index)
                : Colors.grey.withOpacity(0.3),
              ),
            ),),
          );
        }),
      ],
    );
  }

  Color _getIndicatorColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFD95554);
      case 1:
        return const Color(0xFFFFB301);
      case 2:
        return const Color(0xFF41AAF5);
      default:
        return Colors.grey;
    }
  }
}
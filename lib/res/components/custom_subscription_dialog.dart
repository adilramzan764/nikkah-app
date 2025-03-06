import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../view_model/edit_profile_controller.dart';

class SubscriptionDialog extends StatelessWidget {
  final String tier;
  final double price;
  final Color border;
  final Color titleColor;
  final List<String> features;
  final LinearGradient buttonGradient;
  final EditProfileController controller;

  const SubscriptionDialog({
    super.key,
    required this.tier,
    required this.price,
    required this.border,
    required this.features,
    required this.titleColor,
    required this.controller,
    required this.buttonGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: border, width: 1.5,),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: titleColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  tier,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "What's Included",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 40),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: titleColor.withOpacity(0.1),
                    ),
                    child: Icon(Icons.check, size: 16, color: titleColor,),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    feature,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),
            Text(
              '\$$price.00',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const Text(
              'Per Month',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                controller.handleUpgrade(tier);
                Get.back();
                Get.snackbar(
                  'Subscription Upgraded',
                  'You have successfully upgraded to $tier!',
                  duration: const Duration(seconds: 2),
                  borderRadius: 10,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: titleColor.withOpacity(0.8),
                  colorText: Colors.white,
                );
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: buttonGradient,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Upgrade',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
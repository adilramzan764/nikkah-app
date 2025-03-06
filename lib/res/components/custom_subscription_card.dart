import '../colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';
import 'custom_subscription_dialog.dart';
import '../../model/subscription_features_model.dart';
import '../../view_model/edit_profile_controller.dart';

class SubscriptionCard extends StatelessWidget {
  final int index;
  final String title;
  final bool isSelected;
  final LinearGradient? gradient;
  final EditProfileController controller;
  final List<SubscriptionFeature> features;

  const SubscriptionCard({
    super.key,
    this.gradient,
    required this.title,
    required this.index,
    required this.features,
    this.isSelected = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.setActiveSubscription(index);
      },
      child: Container(
        width: 347,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _getBorderColor(), width: 1.5,),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 81,
                  height: 27,
                  decoration: BoxDecoration(
                    color: _getTitleColor(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyles.editProfileScreenSubscriptionUpgradeButton,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSubscriptionDialog(context),
                  child: Container(
                    width: 95,
                    height: 27,
                    decoration: BoxDecoration(
                      gradient: _getUpgradeButtonGradient(),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        'Upgrade',
                        style: TextStyles.editProfileScreenSubscriptionUpgradeButton,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'What\'s Includes',
                    style: TextStyles.editProfileScreenSubscriptionFeaturesTitle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Free',
                        style: TextStyles.editProfileScreenSubscriptionFeaturesTitle,
                      ),
                      Text(
                        title,
                        style: TextStyles.editProfileScreenSubscriptionFeaturesTitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      maxLines: 2,
                      feature.feature,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.editProfileScreenSubscriptionFeatures,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          feature.freeIncluded ? '✓' : '-',
                          style: TextStyles.editProfileScreenSubscriptionFeatures,
                        ),
                        const Icon(Icons.check, size: 14, color: Colors.black45),
                      ],
                    ),
                  ),
                ],
              ),
            ),),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor() {
    switch (title.toLowerCase()) {
      case 'platinum': return AppColors.platinumColor;
      case 'gold': return AppColors.goldColor;
      default: return AppColors.silverColor;
    }
  }

  Color _getTitleColor() {
    switch (title.toLowerCase()) {
      case 'platinum': return AppColors.platinumColor;
      case 'gold': return AppColors.goldColor;
      default: return AppColors.silverColor;
    }
  }

  LinearGradient _getUpgradeButtonGradient() {
    switch (title.toLowerCase()) {
      case 'platinum': return const LinearGradient(
        colors: [Color(0xFFF05F57), Color(0xFF360940)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
      case 'gold': return const LinearGradient(
        colors: [Color(0xFFFDD819), Color(0xFFE80505)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      case 'silver': return const LinearGradient(
        colors: [Color(0xFF1B9DF0), Color(0xFF9708CC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      default: return const LinearGradient(
        colors: [Color(0xFF41AAF5), Color(0xFF3B5998)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  void _showSubscriptionDialog(BuildContext context) {
    final subscriptionData = {
      'platinum': {
        'price': 124.00,
        'features': [
          'See who likes you',
          'All nearby you',
          'See who likes you',
        ],
        'titleColor': _getTitleColor(),
        'buttonGradient': _getUpgradeButtonGradient(),
        'border': _getBorderColor()
      },
      'gold': {
        'price': 99.00,
        'features': [
          'See who likes you',
          'All nearby you',
          'Premium support',
        ],
        'titleColor': _getTitleColor(),
        'buttonGradient': _getUpgradeButtonGradient(),
        'border': _getBorderColor()
      },
      'silver': {
        'price': 49.00,
        'features': [
          'See who likes you',
          'All nearby you',
          'Basic support',
        ],
        'titleColor': _getTitleColor(),
        'buttonGradient': _getUpgradeButtonGradient(),
        'border': _getBorderColor()
      },
    };

    final data = subscriptionData[title.toLowerCase()]!;

    showDialog(
      context: context,
      builder: (context) => SubscriptionDialog(
        tier: title,
        price: data['price'] as double,
        features: (data['features'] as List<String>),
        titleColor: data['titleColor'] as Color,
        buttonGradient: data['buttonGradient'] as LinearGradient,
        border: data['border'] as Color,
        controller: controller,
      ),
    );
  }
}
import '../../model/subscription_features_model.dart';

class SubscriptionFeaturesList {
  static final Map<String, List<SubscriptionFeature>> features = {
    'platinum': [
      SubscriptionFeature(
        freeIncluded: false,
        platinumIncluded: true,
        feature: 'See who likes you',
      ),
      SubscriptionFeature(
        freeIncluded: false,
        platinumIncluded: true,
        feature: 'All nearby you',
      ),
      SubscriptionFeature(
        freeIncluded: false,
        platinumIncluded: true,
        feature: 'See who likes you',
      ),
    ],
    'gold': [
      SubscriptionFeature(
        goldIncluded: true,
        freeIncluded: false,
        feature: 'Priority Likes',
      ),
      SubscriptionFeature(
        goldIncluded: true,
        freeIncluded: false,
        feature: 'Unlimited rewinds',
      ),
      SubscriptionFeature(
        goldIncluded: true,
        freeIncluded: false,
        feature: 'See who likes you',
      ),
    ],
    'silver': [
      SubscriptionFeature(
        freeIncluded: false,
        silverIncluded: true,
        feature: 'Unlimited Likes',
      ),
      SubscriptionFeature(
        freeIncluded: false,
        silverIncluded: true,
        feature: 'Unlimited rewinds',
      ),
      SubscriptionFeature(
        freeIncluded: false,
        silverIncluded: true,
        feature: 'See who likes you',
      ),
    ],
  };
}
class SubscriptionFeature {
  final String feature;
  final bool goldIncluded;
  final bool freeIncluded;
  final bool silverIncluded;
  final bool platinumIncluded;

  SubscriptionFeature({
    required this.feature,
    this.freeIncluded = false,
    this.goldIncluded = false,
    this.silverIncluded = false,
    this.platinumIncluded = false,
  });
}
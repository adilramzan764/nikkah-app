import '../colors/app_colors.dart';
import 'package:flutter/material.dart';

class GradientSlider extends StatelessWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  const GradientSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: AppColors.greyColor.withOpacity(0.3),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
      ),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ).createShader(bounds);
        },
        child: Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          inactiveColor: AppColors.greyColor.withOpacity(0.3),
        ),
      ),
    );
  }
}

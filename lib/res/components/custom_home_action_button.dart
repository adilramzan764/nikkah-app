import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;

  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: gradientColors.first,),
        gradient: null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Icon(icon, size: 25, color: Colors.white,),
            ),
          ),
        ),
      ),
    );
  }
}
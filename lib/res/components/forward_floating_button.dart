import 'package:flutter/material.dart';

class ForwardFloatingButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final VoidCallback onPressed;
  final List<Color> gradientColors;

  const ForwardFloatingButton({
    super.key,
    this.size = 50.0,
    required this.icon,
    required this.onPressed,
    this.gradientColors = const [
      Color(0xFF43CBFF),
      Color(0xFF9708CC)
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6.0,
            offset: Offset(0, 3),
            color: Colors.black26,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(child: Icon(icon, color: Colors.white, size: size / 2,),),
        ),
      ),
    );
  }
}
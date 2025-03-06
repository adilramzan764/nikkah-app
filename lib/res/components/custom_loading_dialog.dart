import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black45,
      backgroundColor: Colors.white,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue], // Gradient colors
              ).createShader(bounds);
            },
            child: const CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Please wait, your request is processing.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
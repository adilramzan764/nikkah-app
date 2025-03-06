import 'package:flutter/material.dart';
import 'package:nikkah_app/res/colors/colors.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomStepper({
    super.key,
    this.activeColor,
    this.inactiveColor,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isActive
              ? (activeColor ?? AppColorsTwo.stepper)
              : (inactiveColor ?? AppColorsTwo.stepperOne),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}














// import 'package:flutter/material.dart';
// import 'package:nikkah_app/res/colors/colors.dart';
//
// class CustomStepper extends StatelessWidget {
//   final int currentStep;
//   final int totalSteps;
//
//   const CustomStepper({
//     super.key,
//     required this.currentStep,
//     required this.totalSteps,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(totalSteps, (index) {
//         final isActive = index <= currentStep;
//           return Expanded(
//           child: Container(
//             height: 4,
//             margin: const EdgeInsets.symmetric(horizontal: 2),
//             decoration: BoxDecoration(
//               color: isActive ? AppColors.stepper : AppColors.stepperOne,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
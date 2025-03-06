import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nikkah_app/view_model/edit_profile_controller.dart';

class EditDialogHelper {
  static void showEditDialog(
    BuildContext context,
    TextEditingController textController,
    String field,
    String label,
    Function(String) onUpdate,
  ) {
    final EditProfileController userProfileController = Get.find<EditProfileController>();
    textController.text = _getUserProfileField(userProfileController, field);
    int wordCount = _countWords(textController.text);
    const int maxWords = 300;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void onTextChanged(String text) {
              if (!_requiresWordLimit(field)) return;

              List<String> words = text.trim().split(RegExp(r'\s+'));
              int newWordCount = words.where((word) => word.isNotEmpty).length;

              setState(() {
                wordCount = newWordCount;
              });

              if (wordCount > maxWords) {
                List<String> validWords = words.sublist(0, maxWords);
                textController.text = validWords.join(" ");
                textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: textController.text.length),
                );
                setState(() {
                  wordCount = maxWords;
                });

                // Show Snackbar Alert
                Get.snackbar(
                  'Word Limit Exceeded',
                  'You can only enter up to $maxWords words!',
                  colorText: Colors.white,
                  backgroundColor: Colors.redAccent,
                  duration: const Duration(seconds: 2),
                );
              }
            }

            return Theme(
              data: ThemeData(useMaterial3: false),
              child: AlertDialog(
                title: Text('Edit $field'),
                content: TextField(
                  controller: textController,
                  keyboardType: (field == 'Age' || field == 'Height')
                  ? TextInputType.number
                  : TextInputType.text,
                  decoration: InputDecoration(
                    labelText: label,
                    border: const OutlineInputBorder(),
                    counterText: _requiresWordLimit(field)
                    ? '$wordCount / $maxWords words'
                    : null,
                  ),
                  onChanged: _requiresWordLimit(field) ? onTextChanged : null,
                  // maxLines: (field == 'Description') ? 5 : 1,
                  maxLines: 5,
                  minLines: 1,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        onUpdate(textController.text);
                        Get.back();
                      } else {
                        Get.snackbar('Error', 'Please enter $field details');
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static String _getUserProfileField(EditProfileController controller, String field) {
    switch (field) {
      case 'Education Level':
        return controller.education.value;
      case 'Drink':
        return controller.drink.value;
      case 'Languages':
        return controller.languages.join(', ');
      case 'Intentions':
        return controller.intentions.value;
      case 'Gender':
        return controller.gender.value;
      case 'Job Title':
        return controller.jobTitle.value;
      case 'Description':
        return controller.description.value;
      case 'Country':
        return controller.selectedCountry.value;
      case 'Age':
        return controller.age.value;
      case 'Religion':
        return controller.religion.value;
      case 'City':
        return controller.city.value;
      case 'Born':
        return controller.bornPlace.value;
      case 'birthday':
        return controller.date.value;
      case 'community':
        return controller.community.value;
      case 'Height':
        return controller.height.value;
      case 'StarSign':
        return controller.starSign.value;
      case 'workout':
        return controller.workout.value;
      case 'personalities':
        return controller.personalities.join(', ');
      case 'interests':
        return controller.interests.join(', ');
      default:
        return '';
    }
  }

  static bool _requiresWordLimit(String field) {
    return field == 'Description'; // Add more fields if needed
  }

  static int _countWords(String text) {
    return text.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }
}
















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nikkah_app/view_model/edit_profile_controller.dart';
//
// class EditDialogHelper {
//   static void showEditDialog(
//     BuildContext context,
//     TextEditingController textController,
//     String field,
//     String label,
//     Function(String) onUpdate,
//   ) {
//     final UserProfileController userProfileController = Get.find<UserProfileController>();
//     textController.text = userProfileController.education.value;
//
//     // Pre-fill based on type (education or drink)
//     if (field == 'Education Level') {
//       textController.text = userProfileController.education.value;
//     } else if (field == 'Drink') {
//       textController.text = userProfileController.drink.value;
//     } else if (field == 'Languages') {
//       textController.text = userProfileController.languages.join(', ');
//     } else if (field == 'Intentions') {
//       textController.text = userProfileController.intentions.value;
//     } else if (field == 'Gender') {
//       textController.text = userProfileController.gender.value;
//     } else if (field == 'Job Title') {
//       textController.text = userProfileController.jobTitle.value;
//     } else if (field == 'Description') {
//       textController.text = userProfileController.description.value;
//     } else if (field == 'Country') {
//       textController.text = userProfileController.selectedCountry.value;
//     } else if (field == 'Age') {
//       textController.text = userProfileController.age.value;
//     } else if (field == 'Religion') {
//       textController.text = userProfileController.religion.value;
//     } else if (field == 'City') {
//       textController.text = userProfileController.city.value;
//     } else if (field == 'Born') {
//       textController.text = userProfileController.bornPlace.value;
//     } else if (field == 'birthday') {
//       textController.text = userProfileController.date.value;
//     } else if (field == 'community') {
//       textController.text = userProfileController.community.value;
//     } else if (field == 'Height') {
//       textController.text = userProfileController.height.value;
//     } else if (field == 'StarSign') {
//       textController.text = userProfileController.starSign.value;
//     } else if (field == 'workout') {
//       textController.text = userProfileController.workout.value;
//     } else if (field == 'personalities') {
//       textController.text = userProfileController.personalities.join(', ');
//     } else if (field == 'interests') {
//       textController.text = userProfileController.interests.join(', ');
//     }
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Theme(
//           data: ThemeData(useMaterial3: false),
//           child: AlertDialog(
//             // backgroundColor: Colors.white,
//             title: Text('Edit $field'),
//             content: TextField(
//               controller: textController,
//               keyboardType: (field == 'Age' || field == 'Height')
//               ? TextInputType.number : TextInputType.text,
//               decoration: InputDecoration(
//                 labelText: label,
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   if (textController.text.isNotEmpty) {
//                     onUpdate(textController.text);
//                     Get.back();
//                   } else {
//                     Get.snackbar('Error', 'Please enter $field details');
//                   }
//                 },
//                 child: const Text('Update'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//
//
// //this is for the testing of data
//
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// i
//
// class PhotoModel {
//   final String? path;
//   final bool isSelected;
//
//   PhotoModel({
//     this.path,
//     this.isSelected = false,
//   });
//
//   PhotoModel copyWith({
//     String? path,
//     bool? isSelected,
//   }) {
//     return PhotoModel(
//       path: path ?? this.path,
//       isSelected: isSelected ?? this.isSelected,
//     );
//   }
// }
//
// class PhotoViewModel extends GetxController {
//   final RxList<PhotoModel> photos = List.generate(
//     6,
//         (index) => PhotoModel(),
//   ).obs;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImageFromGallery(int index) async {
//     try {
//       final XFile? image = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );
//
//       if (image != null) {
//         File imageFile = File(image.path);
//
//         int fileSize = await imageFile.length();
//         if (fileSize > 10 * 1024 * 1024) {
//           Get.snackbar(
//             'Error',
//             'Image size should be less than 10MB',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//           return;
//         }
//
//         photos[index] = PhotoModel(
//             path: image.path,
//             isSelected: true
//         );
//
//         photos.refresh();
//
//       } else {
//         if (kDebugMode) {
//           print('No image selected');
//         }
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick image: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   void removePhoto(int index) {
//     photos[index] = PhotoModel();
//     photos.refresh();
//   }
//
//   bool get hasSelectedPhotos => photos.any((photo) => photo.isSelected);
//
//   Future<void> showSuccessDialog() {
//     return Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF2196F3), Color(0xFF6C63FF)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Great!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Your account has been created Successfully!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }
// }
//
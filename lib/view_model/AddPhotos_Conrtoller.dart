import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPhotos_Controller extends GetxController {
  static AddPhotos_Controller get to => Get.find();

  final imageList = <String>[].obs;
  final ImagePicker _picker = ImagePicker();
  final cloudinary = CloudinaryPublic('dmkxs3hdp', 'my-upload-preset', cache: false);

  bool get hasImages => imageList.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    fetchUserImages();
  }

  Future<void> fetchUserImages() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        final snapshot = await databaseReference.child('user_images').child(user.uid).get();

        if (snapshot.exists) {
          final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          List<String> urls = [];
          values.forEach((key, value) {
            urls.add(value['url']);
          });
          imageList.assignAll(urls);
        }
      }
    } catch (e) {
      print('Error fetching user images: $e');
    }
  }

  Future<void> pickImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: 'user_images'),
        );

        final imageUrl = cloudinaryResponse.secureUrl;

        // Agar index pe pehle se image hai toh usay remove karke replace karo
        if (index < imageList.length) {
          imageList[index] = imageUrl;
        } else {
          imageList.add(imageUrl);
        }

        // Firebase me bhi replace/update karo
        await updateImageUrlInDatabase(index, imageUrl);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick and upload image: $e');
    }
  }

  Future<void> saveImageUrlToDatabase(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        await databaseReference.child('user_images').child(user.uid).push().set({
          'url': imageUrl,
          'timestamp': ServerValue.timestamp,
        });
      }
    } catch (e) {
      print('Error saving image URL to database: $e');
    }
  }

  Future<void> updateImageUrlInDatabase(int index, String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        final userImagesRef = databaseReference.child('user_images').child(user.uid);

        print('Checking Firebase reference: ${userImagesRef.path}');

        final snapshot = await userImagesRef.get();

        if (snapshot.exists) {
          final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          final keys = values.keys.toList();

          if (index < keys.length) {
            String imageKey = keys[index];
            await userImagesRef.child(imageKey).update({
              'url': imageUrl,
              'timestamp': ServerValue.timestamp,
            });
            print('Image updated at index: $index');
          } else {
            // Agar index out of bounds hai, toh naya image push karo
            await userImagesRef.push().set({
              'url': imageUrl,
              'timestamp': ServerValue.timestamp,
            });
            print('New image added.');
          }
        } else {
          // Agar koi image mojood nahi, toh naya push karo
          await userImagesRef.push().set({
            'url': imageUrl,
            'timestamp': ServerValue.timestamp,
          });
          print('First image added.');
        }
      } else {
        print('Error: User not logged in.');
      }
    } catch (e) {
      print('Firebase Error: $e');
    }
  }
}